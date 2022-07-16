extends StaticBody2D

export var speed = 3

var dieValue = 1
var tileSize = 16
var castDirection: Vector2
var tilesMoved = dieValue

onready var ray = $RayCast2D
onready var tween = $Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2.ONE * tileSize)
	position += Vector2.ONE * tileSize/2 # makes sure that the player is always centered

func playerCollision(playerFacingDirection:Vector2):
	castDirection = playerFacingDirection
	tilesMoved = 0

func moveTween():
	tween.interpolate_property(self, "position", position, position + castDirection * tileSize *2, 
		1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
func move():
	ray.cast_to = castDirection * tileSize * 2
	ray.force_raycast_update()
	if !ray.is_colliding() and tilesMoved <= dieValue-1:
#		position += castDirection * tileSize * 2
		moveTween()
		tilesMoved += 1
	
#	position += Vector2.ONE * tileSize/2 # makes sure that the player is always centered
	
	if tilesMoved == dieValue:
#		position = position.snapped(Vector2.ONE * tileSize)
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move()
