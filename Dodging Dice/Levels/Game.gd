extends Node2D

onready var PV:Node = $"/root/player_variables";
onready var coin_counter:Node = $"GUI/Coin Counter";
var current_level:int = 5;
var level_count:int = 7; #excluding tutorial, including home
var levels = [];
const TUTORIAL:int = -1;

func _ready():
	#load levels
	for i in range(level_count):
		levels.append(load("res://Levels/Level "+str(i)+".tscn"));
	levels.append(load("res://Levels/Tutorial.tscn"));
	#add current level
	add_level(current_level);

func add_level(n):
	#disable save position
	var is_restart:bool = true if n==current_level else false;
	if !is_restart:
		PV.position_saved = false;
	#add level
	var level:Node = levels[n].instance();
	add_child(level);
	#coin counter
	if n > 0:
		coin_counter.visible = true;
	else:
		coin_counter.visible = false;
	current_level = n;
