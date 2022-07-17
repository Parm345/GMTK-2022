extends KinematicBody2D

const WALL:int = 0;
const NOTHING:int = -1;
onready var walls:Node = get_parent();
onready var snap:Node = $"Snap SFX";
onready var ray:Node = $"RayCast2D";
var rng = RandomNumberGenerator.new();
var tile_size:float = 32;
export var value:int = 1;
var dice_sprites = [];
var distance:float = 0;
var speed:float = 32;
var direction:Vector2 = Vector2(0, 0); #normalized velocity vector
var velocity:Vector2 = Vector2(0, 0);
var target_position:Vector2 = Vector2(0, 0);
var sliding:bool = false;
var randomize_at_stop:bool = true;
var rays = [];
var areas = [];

export var willBecomeBlank = true

func _ready():
	#get rays
	for i in range(8):
		var ray_short:Node = get_node("RayCast2D " + str(i));
		rays.append(ray_short);
	#get areas
	for i in range(4):
		var area:Node = get_node("Area2D " + str(i));
		areas.append(area);
	#get dice sprites
	for i in range(7):
		var sprite:Node = get_node("Dice "+str(i));
		dice_sprites.append(sprite);
	#initialize die value (See Script Variables)
#	var tile_position:Vector2 = walls.world_to_map(global_position);
#	var specified_value:int = walls.die_values[tile_position.x][tile_position.y];
#	if specified_value != 0:
#		value = specified_value;
	dice_sprites[value].visible = true;
	
	if !willBecomeBlank:
		set_modulate(Color.red)

func _physics_process(delta):
#	prints(sliding, global_position, target_position, value);
	if sliding:
		if are_equal_approx(global_position, target_position, 1.0):
			global_position = target_position;
			sliding = false; #end of movement
			if randomize_at_stop && value != 0:
				randomize_value();
		else:
			global_position += velocity*delta;
			update_rays(rays);
			var collided_with_die:bool = false;
			var other:Node;
			if direction==Vector2(0,-1):
				if rays[0].is_colliding() && rays[0].get_collider().is_in_group("dice"):
					collided_with_die = true;
					other = rays[0].get_collider();
				elif rays[1].is_colliding() && rays[1].get_collider().is_in_group("dice"):
					collided_with_die = true;
					other = rays[1].get_collider();
			elif direction==Vector2(1,0):
				if rays[2].is_colliding() && rays[2].get_collider().is_in_group("dice"):
					collided_with_die = true;
					other = rays[2].get_collider();
				elif rays[3].is_colliding() && rays[3].get_collider().is_in_group("dice"):
					collided_with_die = true;
					other = rays[3].get_collider();
			elif direction==Vector2(0,1):
				if rays[4].is_colliding() && rays[4].get_collider().is_in_group("dice"):
					collided_with_die = true;
					other = rays[4].get_collider();
				elif rays[5].is_colliding() && rays[5].get_collider().is_in_group("dice"):
					collided_with_die = true;
					other = rays[5].get_collider();
			elif direction==Vector2(-1,0):
				if rays[6].is_colliding() && rays[6].get_collider().is_in_group("dice"):
					collided_with_die = true;
					other = rays[6].get_collider();
				elif rays[7].is_colliding() && rays[7].get_collider().is_in_group("dice"):
					collided_with_die = true;
					other = rays[7].get_collider();
			
			if collided_with_die:
				var other_distance:float = grid_distance(other.global_position, other.target_position);
				var self_distance:float = grid_distance(global_position, target_position);
				if self_distance >= other_distance:
					retreat();

#			var collision = move_and_collide(Vector2(0,0));
#			if collision:
#				if collision.collider.is_in_group("players") && collision.get_normal()==-direction:
#					retreat();
#				elif collision.collider.is_in_group("dice") && collision.get_normal()==-direction:
#					var other_distance:float = grid_distance(collision.collider.global_position, collision.collider.target_position);
#					var self_distance:float = grid_distance(global_position, target_position);
#					if self_distance >= other_distance:
#						target_position = rounded_multiple(global_position-direction, 32);
			#snap sound
			if !snap.playing && are_equal_approx(global_position, rounded_multiple(global_position, 32), 1):
				play_sound(snap, -2);

func move(direction):
	#check for dies in path
	ray.cast_to = value*tile_size*direction;
	ray.force_raycast_update();
	if ray.is_colliding() && ray.get_collider().is_in_group("dice"):
		return;
	#check for walls in path
	var tile_position:Vector2 = walls.world_to_map(global_position);
	for i in range(value):
		tile_position += direction;
		if walls.get_cell(tile_position.x, tile_position.y)==WALL:
			return;
	#check if already moving
	if sliding:
		return;
	self.direction = direction;
	target_position = rounded_multiple(global_position,32) + direction*value*tile_size;
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

func halt(): #continue forward to nearest tile
	target_position = global_position/tile_size
		
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
	v.x = int(n*round(v.x/float(n)));
	v.y = int(n*round(v.y/float(n)));
	return v;

func rounded(v):
	v.x = round(v.x);
	v.y = round(v.y);
	return v;

func grid_distance(v1, v2):
	return abs(v1.x-v2.x)+abs(v1.y-v2.y);

func randomize_value():
	rng.randomize();
	if willBecomeBlank:
		var rand:float = rng.randf_range(0,1);
		var new_value:int = 0;
		if rand < 0.4:
			new_value = 0;
		else:
			new_value = ceil((rand-0.4)/0.1);
		change_value(new_value);
	else:
		var rand = rng.randi_range(1, 6)
		change_value(rand)

func change_value(new_value):
	dice_sprites[value].visible = false;
	value = new_value;
	dice_sprites[value].visible = true;

func play_sound(player, volume):
	player.set_volume_db(volume);
	player.play();
	
func update_rays(rays):
	for r in rays:
		r.force_raycast_update();

func _on_Area2D_0_body_entered(body):
	if body.is_in_group("players") && sliding && direction==Vector2(0,-1):
		retreat();

func _on_Area2D_1_body_entered(body):
	if body.is_in_group("players") && sliding && direction==Vector2(1,0):
		retreat();

func _on_Area2D_2_body_entered(body):
	if body.is_in_group("players") && sliding && direction==Vector2(0,1):
		retreat();

func _on_Area2D_3_body_entered(body):
	if body.is_in_group("players") && sliding && direction==Vector2(-1,0):
		retreat();
