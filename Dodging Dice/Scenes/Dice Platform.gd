extends TileMap

onready var player:Node = $"../Player";
var solid_time:float = 0.4;
const NOTHING:int = -1;

func _ready():
	player.connect("collided", self, "_on_Player_collided");

func _on_Player_collided(collision):
	#remove tile from tilemap, spawn bouncing die
	if collision.collider is TileMap:
		var collision_pos:Vector2 = world_to_map(collision.position - collision.get_normal());
		var type:int = get_cell(collision_pos.x, collision_pos.y);
		if type >= 1 && type <= 6:
			set_cell(collision_pos.x, collision_pos.y, NOTHING);
