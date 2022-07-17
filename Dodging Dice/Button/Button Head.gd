extends StaticBody2D

signal pressed;
#var rising:bool = false;
var sinking:bool = false;
var speed:float = 5;
var final_y:float = -5;
var initial_y:float = -15;
var just_pressed:bool = false;

func _physics_process(delta):
	if sinking:
		position.y += speed*delta;
		if is_approx_greater(position.y, final_y, 0.005):
			sinking = false;
			emit_signal("pressed");
			just_pressed = true;
	else: #rising
		just_pressed = false;
		if position.y > initial_y:
			position.y = max(position.y-speed*delta, initial_y);
	sinking = false;

func is_approx_greater(a, b, tolerance):
	if a >= b-tolerance:
		return true;
	return false;
