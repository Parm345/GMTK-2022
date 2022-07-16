extends player_state

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var isJumping = false
# Called when the parent enters the state
func enter(scriptParent):
	parent = scriptParent
	parent.velocity.x = 0
	parent.playAnimation("idle") 

func inPhysicsProcess(delta):
	if !parent.is_on_floor():
		parent.playAnimation("fall")
	else:
		parent.playAnimation("idle")
	

func changeParentState():
#	print(parent.is_on_floor())
	if parent.is_on_floor() and isJumping:
		isJumping = false
		return states.jump
	if abs(parent.velocity.x) > 0:
		return states.run
	return null

func handleInput(event):
	if event.is_action_pressed("jump"):
		isJumping = true
#		print(get_parent().curState)
