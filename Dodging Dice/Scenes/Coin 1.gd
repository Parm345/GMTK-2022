extends Area2D

onready var collider:Node = $"CollisionShape2D";
onready var animation:Node = $"AnimatedSprite";
onready var PV:Node = $"/root/player_variables";
onready var coin_counter:Node = $"/root/Game/GUI/Coin Counter";
onready var game:Node = $"/root/Game";
const WIDTH:float = 4.0;
const DIAMETER:float = 16.0;

func _process(delta):
	collider.scale.x = WIDTH/DIAMETER + abs(sin(animation.frame/32.0*PI))*(DIAMETER-WIDTH)/DIAMETER;

func _on_Coin_1_body_entered(body):
	if body.is_in_group("players"):
		if game.current_level != -1:
			PV.level_coin_count += 1;
			coin_counter.update_coin_count(true);
		body.get_node("Audio/Coin 1").play();
		queue_free();
