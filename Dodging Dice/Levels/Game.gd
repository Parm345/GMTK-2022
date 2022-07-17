extends Node2D

onready var PV:Node = $"/root/player_variables";
onready var coin_counter:Node = $"GUI/Coin Counter";
var current_level:int = 0;
var level_count:int = 2; #excluding tutorial
var levels = [];
const TUTORIAL:int = -1;

func _ready():
	for i in range(level_count):
		levels.append(load("res://Levels/Level "+str(i)+".tscn"));
	levels.append(load("res://Levels/Tutorial.tscn"));

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
