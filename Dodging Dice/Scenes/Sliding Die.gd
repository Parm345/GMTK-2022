extends KinematicBody2D

var tile_size:float = 32;
var value:int = 1;
var dice_sprites = [];
var distance:float = 0;
var speed:float = 32;
var velocity:Vector2 = Vector2(0, 0);
var target_position:Vector2 = Vector2(0, 0);
var sliding:bool = false;

func _ready():
	for i in range(7):
		var sprite:Node = get_node("Dice "+str(i));
		dice_sprites.append(sprite);
	dice_sprites[value].visible = true;

func _physics_process(delta):
	if sliding:
		if are_equal_approx(global_position, target_position):
			global_position = target_position;
			sliding = false;
		else:
			move_and_slide(velocity, Vector2(0, 0));
		

func move(direction):
	if sliding:
		return;
	target_position = global_position + direction*value*tile_size;
	velocity = speed*direction;
	sliding = true;
		
func are_equal_approx(position1, position2):
	if abs(position1.x-position2.x) < 1 && abs(position1.y-position2.y) < 1:
		return true;
	return false;
