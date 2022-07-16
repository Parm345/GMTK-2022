extends KinematicBody2D

signal collided;

const weight:int = 2;
const DASH_SPEED = 750
const DASH_RANGE = DASH_SPEED * 2
const HORZ_MAX_SPEED = 100
const HORZ_ACC = 25
const UP = Vector2(0, -1)

export var jumpForce = 500
var gravity = 15
var velocity:Vector2 = Vector2()
var isFacingRight = true
var hasJumped = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$FSM.setState($FSM.states.idle)

func applyGravity(delta):
	velocity.y += gravity

# Process Functions

func _physics_process(delta):
	applyGravity(delta)
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += HORZ_ACC
		isFacingRight = true
	if Input.is_action_pressed("ui_left"):
		velocity.x -= HORZ_ACC
		isFacingRight = false
	if Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
		velocity.x = 0
	
	if $FSM.curState != $FSM/dash:
		velocity.x = clamp(velocity.x, -HORZ_MAX_SPEED, HORZ_MAX_SPEED)
	
	move_and_slide(velocity, UP);

#	print(velocity)
#
#func _input(event):
#	if event.is_action_pressed("jump"):
#		velocity.x
