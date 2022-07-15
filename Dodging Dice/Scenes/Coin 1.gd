extends Area2D

onready var collider:Node = $"CollisionShape2D";
onready var animation:Node = $"AnimatedSprite";
var WIDTH:float = 4.0;
var DIAMETER:float = 16.0;

func _process(delta):
	collider.scale.x = WIDTH/DIAMETER + abs(sin(animation.frame/32.0*PI))*(DIAMETER-WIDTH)/DIAMETER;
