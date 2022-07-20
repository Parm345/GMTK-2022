extends Node2D

onready var game:Node = $"/root/Game";
onready var music:Node = game.get_node("Audio/Ditto Fast");
const TUTORIAL:int = -1;

func _ready():
	music.connect("finished", self, "_on_Music_finished");
	music.play();

func _on_Start_Button_button_up():
	music.stop();
	game.add_level(1);
	queue_free();


func _on_Tutorial_Button_button_up():
	music.stop();
	game.add_level(TUTORIAL);
	queue_free();

func _on_Music_finished():
	music.play();
