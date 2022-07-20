extends StaticBody2D

signal pressed;
onready var save_sound:Node = $"/root/Game/Audio/Save";
#var weight:float = 0;
#var threshold:float = 6;
#var start_y:float = -15;
#var end_y:float = -5;
#var button_range:float = abs(end_y-start_y);

#func _process(delta):
#	button_head.position.y = max(end_y, start_y + weight/threshold*button_range);

func _on_Button_Head_pressed():
	save_sound.play();
	emit_signal("pressed");
