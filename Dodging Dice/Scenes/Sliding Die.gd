extends KinematicBody2D

var t:float = 32;
var value:int = 1;
var speed:float = 32;
var dice_sprites = [];
var distance:float = 0;

func _ready():
	for i in range(7):
		var sprite:Node = get_node("Dice "+str(i));
		dice_sprites.append(sprite);
	dice_sprites[value].visible = true;

func move(direction):
	var velocity:Vector2 = speed*direction;
	velocity = move_and_slide(velocity, Vector2(0,0));
		
