extends Node2D

onready var coin_counter:Node = $"GUI/Coin Counter";
var current_level:int = 0;
var level_count:int = 2;
var levels = [];

func _ready():
	for i in range(level_count):
		levels.append(load("res://Levels/Level "+str(i)+".tscn"));

func add_level(n):
	var level:Node = levels[n].instance();
	add_child(level);
	if n > 0:
		coin_counter.visible = true;
	else:
		coin_counter.visible = false;
	current_level = n;
