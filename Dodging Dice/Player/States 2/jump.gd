extends player_state

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var jumpForce = parent.jump_force

var animations = ["jump start", "fall"]
var currentAnimation = null
var isHoldingJump = true

# Called when the parent enters the state
func enter(scriptParent):
	parent = scriptParent
	currentAnimation = animations[0]
	isHoldingJump = true
	parent.jump()

# Called when parent leaves the state, most likely not necessary 
func exit():
	currentAnimation = null
	isHoldingJump = false

# Called every physics frame. 'delta' is the elapsed time since the previous frame. Run in FSM _physics_process.
func inPhysicsProcess(delta):
	if currentAnimation != null:
		parent.playAnimation(currentAnimation)
	
	if parent.velocity.y > 0 or Input.is_action_just_released("jump"):
		currentAnimation = animations[1]
		isHoldingJump = false
	
	if !isHoldingJump:
		parent.velocity.y += parent.gravity 

func changeParentState():
	if parent.is_on_floor():
		return states.idle
	return null

func handleInput(event):
	pass

func _on_AnimatedSprite_animation_finished():
	if currentAnimation == animations[1]:
		parent.get_node("AnimatedSprite").frame = 1
