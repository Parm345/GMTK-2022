extends StaticBody2D

export var speed = 0.1

var dieValue = 3
var tileSize = 32
var castDirection: Vector2 = Vector2()
var tilesMoved = dieValue
var isMoving = false
var checkTile = false
var movedAlongTile = 0

onready var ray = $RayCast2D
onready var ray2 = $RayCast2D2
onready var tween = $Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2.ONE * tileSize)
	position += Vector2.ONE * tileSize/2 # makes sure that the player is always centered

func playerCollision(playerFacingDirection:Vector2):
#	position = position.snapped(Vector2.ONE * tileSize)
	if !isMoving:
		ray.cast_to = playerFacingDirection * dieValue * tileSize
		ray.force_raycast_update()
		if !ray.is_colliding():
			castDirection = playerFacingDirection
			isMoving = true
		tilesMoved = 0
		movedAlongTile = 0
#		get_tree().paused = true

func moveTween():
	tween.interpolate_property(self, "position", position, position + castDirection * tileSize, 
		3, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
func move():
	ray.cast_to = castDirection * tileSize
	ray2.cast_to = castDirection * 17
	ray.force_raycast_update()
	ray2.force_raycast_update()
	
	if !ray.is_colliding():
		checkTile = true
	if !ray2.is_colliding() and tilesMoved < dieValue and isMoving and checkTile:
		movedAlongTile += speed
		position += castDirection * speed
		if movedAlongTile >= tileSize:
			tilesMoved += 1
			movedAlongTile = 0
			print(tilesMoved)
#			get_tree().paused = true
	if ray.is_colliding():
		tilesMoved = dieValue

	
	if tilesMoved == dieValue:
		castDirection = Vector2()
		isMoving = false
		position = position.snapped(Vector2.ONE * tileSize)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move()
