extends StaticBody2D

signal pressed;
onready var win_sound:Node = $"/root/Game/Audio/Level Clear";
#var weight:float = 0;
#var threshold:float = 6;
#var start_y:float = -15;
#var end_y:float = -5;
#var button_range:float = abs(end_y-start_y);

#func _process(delta):
#	button_head.position.y = max(end_y, start_y + weight/threshold*button_range);

func _on_Button_Head_pressed():
	win_sound.play();
	yield(win_sound, "finished");
	emit_signal("pressed");
