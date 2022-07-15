extends TileMap

onready var player:Node = $"../Player";
var timer = preload("res://Scenes/Timer (Oneshot).tscn");
var solid_time:float = 0.6;
const NOTHING:int = -1;
var breakings = [];

func _ready():
	player.connect("collided", self, "_on_Player_collided");

func _on_Player_collided(collision):
	#remove tile from tilemap, spawn bouncing die
	if collision.collider is TileMap:
		var collision_pos:Vector2 = world_to_map(collision.position - collision.get_normal());
		var type:int = get_cell(collision_pos.x, collision_pos.y);
		if type >= 1 && type <= 6:
			breakings.append(collision_pos);
			start_timer(solid_time);

func start_timer(sec):
	var instance:Node = timer.instance();
	instance.connect("timeout", self, "_on_Timer_timeout");
	add_child(instance);
	instance.start(sec);

func _on_Timer_timeout():
	var tile_position:Vector2 = breakings.pop_front();
	set_cell(tile_position.x, tile_position.y, NOTHING);
