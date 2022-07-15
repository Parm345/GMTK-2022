extends player_state

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var jumpForce
var isHoldingJump = true

# Called when the parent enters the state
func enter(scriptParent):
	parent = scriptParent 
	jumpForce = parent.jumpForce
	parent.velocity.y = -jumpForce
	isHoldingJump = true
	# jump animation 


# Called every physics frame. 'delta' is the elapsed time since the previous frame. Run in FSM _physics_process.
func inPhysicsProcess(delta):
	if !isHoldingJump:
		parent.velocity.y += parent.gravity * 2
	if Input.is_action_just_released("jump"):
		isHoldingJump = false
		# fall animation 

func changeParentState():
	if parent.is_on_floor():
		return states.idle
	return null

func handleInput(event):
	pass
