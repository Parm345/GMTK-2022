extends StaticBody2D

export var speed = 3

var dieValue = 4
var tileSize = 32
var castDirection: Vector2 = Vector2()
var tilesMoved = dieValue
var isMoving = false

onready var ray = $RayCast2D
onready var tween = $Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2.ONE * tileSize)
	position += Vector2.ONE * tileSize/2 # makes sure that the player is always centered

func playerCollision(playerFacingDirection:Vector2):
	if !isMoving:
		castDirection = playerFacingDirection
		tilesMoved = 0
		isMoving = true
#		get_tree().paused = true

func moveTween():
	tween.interpolate_property(self, "position", position, position + castDirection * tileSize, 
		1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
func move():
	ray.cast_to = castDirection * tileSize
	ray.force_raycast_update()
	if !ray.is_colliding() and tilesMoved < dieValue and isMoving:
		position += castDirection * tileSize
#		moveTween()
		tilesMoved += 1
	if ray.is_colliding():
		tilesMoved = dieValue
		print("yo")

	
	if tilesMoved == dieValue:
		castDirection = Vector2()
		isMoving = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move()
