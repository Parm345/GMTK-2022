extends Node2D

onready var game:Node = $"/root/Game";

func _on_Restart_Button_button_up():
	game.add_level(game.current_level);
	queue_free();

func _on_Home_Button_button_up():
	game.add_level(0);
	queue_free();

func _on_Button_pressed():
	var next_level:int = (game.current_level+1)%game.level_count;
	game.add_level(next_level);
	queue_free();
