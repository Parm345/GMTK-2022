extends Node2D

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
	var level:Node = levels[n].instance();
	add_child(level);
	if n > 0:
		coin_counter.visible = true;
	else:
		coin_counter.visible = false;
	current_level = n;
