extends Node2D

onready var game:Node = $"/root/Game";
const TUTORIAL:int = -1;

func _on_Start_Button_button_up():
	game.add_level(1);
	queue_free();


func _on_Tutorial_Button_button_up():
	game.add_level(TUTORIAL);
	queue_free();
