extends Area2D

onready var collider:Node = $"CollisionShape2D";
onready var animation:Node = $"AnimatedSprite";

func _process(delta):
	collider.scale.x = animation.frame;
