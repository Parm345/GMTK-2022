extends KinematicBody2D

const UP = Vector2(0, -1)
const tileSize = 16

export var speed = 8 # keep as factors/multiples of 16 for error free movement

var dieValue = 4
var velocity:Vector2 = Vector2()
var travelDistance = dieValue * tileSize
var targetPosition: Vector2
var velocityDirection: Vector2

onready var startingPoint = get_global_position()

func _ready():
	pass

func playerCollision(playerFacingDirection:Vector2):
	$"Move Timer".start()
	targetPosition = travelDistance * playerFacingDirection + get_global_position() 
#	print(targetPosition, global_position)
	velocityDirection = playerFacingDirection

func _physics_process(delta):
	print(global_position)
	if is_equal_approx(global_position.y, targetPosition.y) and is_equal_approx(global_position.x, targetPosition.x):
		velocity = Vector2()
		global_position = targetPosition
		
	move_and_collide(velocity)

func _on_Fall_Timer_timeout():
	velocity = velocityDirection * speed
