extends player_state

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var jumpForce
var isHoldingJump = true
var isDashing = false

# Called when the parent enters the state
func enter(scriptParent):
	parent = scriptParent 
	jumpForce = parent.jumpForce
	parent.velocity.y = -jumpForce
	isHoldingJump = true
	isDashing = false
	# jump animation 

func exit():
	parent.velocity.y = 0
	for i in parent.get_slide_count():
		var collision = parent.get_slide_collision(i)
		if collision.collider.has_method("playerCollision"):
			collision.collider.playerCollision(collision.normal*-1) # -1 to return the direction player is facing

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
	if isDashing and !isHoldingJump:
		return states.dash
	return null

func handleInput(event):
	if event.is_action_pressed("dash"):
		isDashing = true
