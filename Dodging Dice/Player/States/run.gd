extends player_state

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var isJumping = false
var isDashing = false
var stoppedMoving = false

# Called when the parent enters the state
func enter(scriptParent):
	parent = scriptParent 
	stoppedMoving = false

# Called every physics frame. 'delta' is the elapsed time since the previous frame. Run in FSM _physics_process.
func inPhysicsProcess(delta):
	if Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
		stoppedMoving = true

func changeParentState():
	if parent.is_on_floor() and isJumping:
		isJumping = false
		return states.jump
	if stoppedMoving:
		return states.idle
	if isDashing:
		isDashing = false
		return states.dash
	return null
	
func handleInput(event):
	if event.is_action_pressed("jump"):
		isJumping = true
	if event.is_action_pressed("dash"):
		isDashing = true
