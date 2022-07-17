extends Node2D

onready var game:Node = $"/root/Game";

func _on_Start_Button_button_up():
	game.add_level(1);
	queue_free();
