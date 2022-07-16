extends TileMap

onready var player:Node = $"../Player";
#var timer = preload("res://Scenes/Timer (Oneshot).tscn");
var solid_time:float = 48;
const NOTHING:int = -1;
var room_tx:int = 32;
var room_ty:int = 20;
var time_remaining = create_array_int(room_tx, room_ty, -1);

func _ready():
	player.connect("collided", self, "_on_Player_collided");

func _physics_process(delta):
	for x in range(room_tx):
		for y in range(room_ty):
			if time_remaining[x][y] > 0:
				time_remaining[x][y] -= 1;
			elif time_remaining[x][y] == 0:
				set_cell(x, y, NOTHING);

func _on_Player_collided(collision):
	#remove tile from tilemap, spawn bouncing die
	if collision.collider is TileMap:
		var collision_pos:Vector2 = world_to_map(collision.position - collision.get_normal());
		var type:int = get_cell(collision_pos.x, collision_pos.y);
		if time_remaining[collision_pos.x][collision_pos.y]<0 && type >= 1 && type <= 6:
			time_remaining[collision_pos.x][collision_pos.y] = solid_time;

#func start_timer(sec, tile_position):
#	var instance:Node = timer.instance();
#	instance.tile_position = tile_position;
#	instance.connect("timeout", self, "_on_Timer_timeout");
#	add_child(instance);
#	instance.start(sec);
#
#func _on_Timer_timeout():
#	var tile_position:Vector2 = breakings.pop_front();
#	set_cell(tile_position.x, tile_position.y, NOTHING);
#	prints("TIMED OUT", breakings);

func create_array_int(x, y, value):
	var a = [];
	for i in range(x):
		var b = [];
		for j in range(y):
			b.append(value);
		a.append(b);
	return a;
