extends KinematicBody2D

signal jumped;
signal landed;
signal airborned;

const DASH_SPEED = 1000
const MAX_GRAV = 1500
var grounded:bool = true;
var maxSpeed = 100
var hforce:float = 10;
var width:float = 24;
var height:float = 24;
var jump_force:float = 450;
var gravity:float = 15;
var velocity:Vector2 = Vector2(0, 0);
var MU_AIR:float = 0.001;
var MU_H:float = 0.06;

var isFacingRight = true

func _ready():
	$FSM.setState($FSM.states.idle)

#func _input(event):
#	if event.is_action_pressed("jump") and is_on_floor():
#		pass

func _physics_process(delta):
	#horizontal movement
	#if is_on_floor():
	if Input.is_action_pressed("ui_left"):
		velocity.x -= hforce;
#		$AnimatedSprite.set_speed_scale(float(abs(velocity.x)/50.0));
		isFacingRight = false
		$AnimatedSprite.flip_h = true
	if Input.is_action_pressed("ui_right"):
#		$AnimatedSprite.set_speed_scale(float(abs(velocity.x)/50.0));
		velocity.x += hforce;
		isFacingRight = true
		$AnimatedSprite.flip_h = false
	if Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
		velocity.x = 0
		$AnimatedSprite.play("idle")
	
	if $FSM.curState != $FSM.states.dash:
		velocity.x = clamp(velocity.x, -maxSpeed, maxSpeed)
		#gravity
		velocity.y += gravity
	
	velocity.y = clamp(velocity.y, -jump_force, MAX_GRAV)
	#move
	velocity = move_and_slide(velocity, Vector2.UP);
	for i in get_slide_count():
		var collision = get_slide_collision(i);
		if collision.collider.is_in_group("dice"):
			collision.collider.move(-collision.get_normal());
	
	#landed/airborned signal
	if is_on_floor():
		if !grounded:
			emit_signal("landed");
			$AnimatedSprite.play("idle")
		grounded = true;
	else:
		if grounded:
			emit_signal("airborned");
		grounded = false;

func jump():
	velocity.y -= jump_force;
	emit_signal("jumped")

func playAnimation(animation:String):
	$AnimatedSprite.play(animation)

