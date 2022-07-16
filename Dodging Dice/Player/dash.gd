extends player_state

var targetPos
var dashPointReached = false

# Called when the parent enters the state
func enter(scriptParent):
	parent = scriptParent 
	dashPointReached = false
	if parent.isFacingRight:
		parent.velocity.x = parent.DASH_SPEED
		targetPos = parent.global_position.x + parent.DASH_RANGE
	if !parent.isFacingRight:
		parent.velocity.x = -parent.DASH_SPEED
		targetPos = parent.global_position.x - parent.DASH_RANGE
#	print(targetPos, parent.global_position)
	$"Dash Time".start()
	
# Called when parent leaves the state, most likely not necessary 
#func exit():
#	for i in parent.get_slide_count():
#		var collision = parent.get_slide_collision(i)
#		if collision.collider.has_method("playerCollision"):
#			if collision.normal != Vector2(0,1) or collision.normal != Vector2(0,-1):
#				collision.collider.playerCollision(collision.normal*-1) # -1 to return the direction player is facing

func changeParentState():
	if dashPointReached or parent.velocity.x == 0:
		return states.idle
	return null
	
func _on_Dash_Time_timeout():
	dashPointReached = true
