extends KinematicBody2D

const WALL:int = 0;
onready var walls:Node = get_parent();
onready var snap:Node = $"Snap SFX";
var rng = RandomNumberGenerator.new();
var tile_size:float = 32;
var value:int = 1;
var dice_sprites = [];
var distance:float = 0;
var speed:float = 32;
var direction:Vector2 = Vector2(0, 0); #normalized velocity vector
var velocity:Vector2 = Vector2(0, 0);
var target_position:Vector2 = Vector2(0, 0);
var sliding:bool = false;
var randomize_at_stop:bool = true;

func _ready():
	for i in range(7):
		var sprite:Node = get_node("Dice "+str(i));
		dice_sprites.append(sprite);
	dice_sprites[value].visible = true;

func _physics_process(delta):
#	print(sliding, target_position, value);
	if sliding:
		if are_equal_approx(global_position, target_position, 1.0):
			global_position = target_position;
			sliding = false; #end of movement
			if randomize_at_stop && value != 0:
				randomize_value();
		else:
			global_position += velocity*delta;
			var collision = move_and_collide(velocity*0);
			if collision:
				if collision.collider.is_in_group("players") && collision.get_normal()==-direction:
					retreat();
			if !snap.playing && are_equal_approx(global_position, rounded_multiple(global_position, 32), 1):
				play_sound(snap, -2);

func move(direction):
	#check for walls/dies in path
	var tile_position:Vector2 = walls.world_to_map(global_position);
	for i in range(value):
		tile_position += direction;
		if walls.get_cell(tile_position.x, tile_position.y)==WALL:
			return;
	if sliding:
		return;
	self.direction = direction;
	target_position = global_position + direction*value*tile_size;
	velocity = speed*direction;
	randomize_at_stop = true;
	sliding = true;

func retreat(): #move backwards to nearest tile
	var old_target_position:Vector2 = target_position;
	target_position = tile_size*rounded_direction(global_position/tile_size-direction, direction);
	direction = -direction;
	velocity = -velocity;
	randomize_at_stop = false;
	#deduct distance traveled from value
	#skill required to catch and stop die
	var new_value:int = grid_distance(target_position/tile_size, old_target_position/tile_size);
	change_value(new_value);
		
func are_equal_approx(position1, position2, tolerance):
	if abs(position1.x-position2.x) < tolerance && abs(position1.y-position2.y) < tolerance:
		return true;
	return false;

func rounded_direction(v, direction):
	if direction.x > 0:
		v.x = ceil(v.x);
	elif direction.x < 0:
		v.x = floor(v.x);
	if direction.y > 0:
		v.y = ceil(v.y);
	elif direction.y < 0:
		v.y = floor(v.y);
	return v;

func rounded_multiple(v, n):
	v.x = n*round(v.x/float(n));
	v.y = n*round(v.y/float(n));
	return v;

func rounded(v):
	v.x = round(v.x);
	v.y = round(v.y);
	return v;

func grid_distance(v1, v2):
	return abs(v1.x-v2.x)+abs(v1.y-v2.y);

func randomize_value():
	rng.randomize();
	var rand:float = rng.randf_range(0,1);
	var new_value:int = 0;
	if rand < 0.4:
		new_value = 0;
	else:
		new_value = ceil((rand-0.4)/0.1);
	change_value(new_value);

func change_value(new_value):
	dice_sprites[value].visible = false;
	value = new_value;
	dice_sprites[value].visible = true;

func play_sound(player, volume):
	player.set_volume_db(volume);
	player.play();
