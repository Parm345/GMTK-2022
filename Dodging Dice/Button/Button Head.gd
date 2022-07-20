extends StaticBody2D

signal pressed;
var sinking:bool = false;
var speed:float = 7;
var final_y:float = -5.0;
var initial_y:float = -15.0;
var just_pressed:bool = false;
var is_pressed:bool = false;

func _physics_process(delta):
	print(position.y);
	#move
	if sinking:
		position.y += speed*delta;
	else: #rising
		if position.y > initial_y:
			position.y = max(position.y-speed*delta, initial_y);
	#check for press
	if is_approx_greater(position.y, final_y, 0.005):
		sinking = false;
		just_pressed = false if is_pressed else true;
		if just_pressed:
			emit_signal("pressed");
			queue_free();
		is_pressed = true;
	else:
		is_pressed = false;
		just_pressed = false;
	#default to rising
	sinking = false;

func sink():
	sinking = true;

func is_approx_greater(a, b, tolerance):
	if a >= b-tolerance:
		return true;
	return false;
