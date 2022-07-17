extends StaticBody2D

signal pressed;
var rising:bool = false;
var sinking:bool = false;
var speed:float = 5;
var final_y:float = 5;
var initial_y:float = -5;

func _physics_process(delta):
	if sinking:
		position.y += speed*delta;
		if position.y >= final_y:
			sinking = false;
			emit_signal("pressed");
	elif rising:
		if position.y > initial_y:
			position.y = max(position.y-speed*delta, initial_y);
		else:
			rising = false;
