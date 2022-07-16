extends KinematicBody2D

const WALL:int = 0;
onready var walls:Node = get_parent();
var rng = RandomNumberGenerator.new();
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
	print(sliding, global_position);
	if sliding:
		if are_equal_approx(global_position, target_position):
			global_position = target_position;
			sliding = false; #end of movement
			if value != 0:
				randomize_value();
		else:
			global_position += velocity/60.0;
		

func move(direction):
	#check for walls/dies in path
	var tile_position:Vector2 = walls.world_to_map(global_position);
	for i in range(value):
		tile_position += direction;
		if walls.get_cell(tile_position.x, tile_position.y)==WALL:
			return;
	if sliding:
		return;
	target_position = global_position + direction*value*tile_size;
	velocity = speed*direction;
	sliding = true;
		
func are_equal_approx(position1, position2):
	if abs(position1.x-position2.x) < 1 && abs(position1.y-position2.y) < 1:
		return true;
	return false;

func randomize_value():
	dice_sprites[value].visible = false;
	rng.randomize();
	var rand:float = rng.randf_range(0,1);
	if rand < 0.4:
		value = 0;
	else:
		value = ceil((rand-0.4)/0.1);
	dice_sprites[value].visible = true;
