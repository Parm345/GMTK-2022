extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const HORZ_MAX_SPEED = 50
const HORZ_ACC = 10
const UP = Vector2(0, -1)

export var jumpForce = 500
var gravity = 15

var velocity:Vector2 = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	$FSM.setState($FSM.states.idle)
	pass # Replace with function body.

func applyGravity(delta):
	velocity.y += gravity

# Process Functions

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	applyGravity(delta)
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += HORZ_ACC
	if Input.is_action_pressed("ui_left"):
		velocity.x -= HORZ_ACC
		
	velocity.x = clamp(velocity.x, -HORZ_MAX_SPEED, HORZ_MAX_SPEED)
	
	velocity = move_and_slide(velocity, UP)
#	print(velocity)
	
