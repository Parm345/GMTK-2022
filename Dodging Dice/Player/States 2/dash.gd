extends player_state

var dashPointReached = false

# Called when the parent enters the state
func enter(scriptParent):
	parent = scriptParent 
	dashPointReached = false
	if parent.isFacingRight:
		parent.velocity.x = parent.DASH_SPEED
	if !parent.isFacingRight:
		parent.velocity.x = -parent.DASH_SPEED
	parent.playAnimation("dash")
	$"Dash Time".start()

func changeParentState():
	if dashPointReached or parent.velocity.x == 0:
		return states.idle
	return null

func _on_Dash_Time_timeout():
	dashPointReached = true
