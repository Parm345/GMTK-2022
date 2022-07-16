extends KinematicBody2D

const UP = Vector2(0, -1)
const tileSize = 32

export var speed = 8 # keep as factors/multiples of 16 for error free movement

var dieValue = 1
var velocity:Vector2 = Vector2()
var travelDistance = dieValue * tileSize
var targetPosition: Vector2
var velocityDirection: Vector2

onready var startingPoint = get_global_position()

func _ready():
	targetPosition = global_position

func playerCollision(playerFacingDirection:Vector2):
	$"Move Timer".start()
	targetPosition = travelDistance * playerFacingDirection + get_global_position() 
	velocityDirection = playerFacingDirection
#	print(targetPosition, global_position)

func _physics_process(delta):
#	print(global_position)
	if is_equal_approx(global_position.y, targetPosition.y) and is_equal_approx(global_position.x, targetPosition.x):
		velocity = Vector2()
		global_position = targetPosition
	if abs(global_position.x) > abs(targetPosition.x) and abs(global_position.y) > abs(targetPosition.y):
		velocity = Vector2()
		global_position = targetPosition
	if abs(global_position.x) < abs(targetPosition.x) and abs(global_position.y) < abs(targetPosition.y):
		velocity = Vector2()
		global_position = targetPosition
		
	var collision = move_and_collide(velocity)
	if collision != null:
		velocity = Vector2()
		targetPosition = global_position

func _on_Fall_Timer_timeout():
	velocity = velocityDirection * speed
