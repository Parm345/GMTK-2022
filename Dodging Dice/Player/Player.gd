extends KinematicBody2D

signal collided;

const weight:int = 2;
const DASH_SPEED = 160
const DASH_RANGE = DASH_SPEED * 2
const HORZ_MAX_SPEED = 100
const HORZ_ACC = 25
const UP = Vector2(0, -1)

export var jumpForce = 500
var gravity = 15

var velocity:Vector2 = Vector2()
var isFacingRight = true

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
	
	if $FSM.curState != $FSM/dash:
		velocity.x = clamp(velocity.x, -HORZ_MAX_SPEED, HORZ_MAX_SPEED)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.has_method("playerCollision"):
			collision.collider.playerCollision(collision.normal*-1) # -1 to return the direction player is facing
	
	move_and_slide(velocity, UP);

#	print(velocity)
#
#func _input(event):
#	if event.is_action_pressed("jump"):
#		velocity.x
