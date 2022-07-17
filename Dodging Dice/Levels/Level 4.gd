extends Node2D

onready var game:Node = $"/root/Game";
onready var player:Node = $"Player 2";

func _input(event):
	if event.is_action_pressed("ui_restart"):
		player.get_node("CollisionShape2D").set_disabled(true);
		game.add_level(game.current_level);
		queue_free();

func _on_Restart_Button_button_up():
	player.get_node("CollisionShape2D").set_disabled(true);
	game.add_level(game.current_level);
	queue_free();

func _on_Home_Button_button_up():
	player.get_node("CollisionShape2D").set_disabled(true);
	game.add_level(0);
	queue_free();

func _on_Button_pressed():
	player.get_node("CollisionShape2D").set_disabled(true);
	var next_level:int = (game.current_level+1)%game.level_count;
	game.add_level(next_level);
	queue_free();
