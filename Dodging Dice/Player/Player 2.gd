extends KinematicBody2D

signal jumped;
signal landed;
signal airborned;
var grounded:bool = true;
var hforce:float = 6.5;
var width:float = 24;
var height:float = 24;
var jump_force:float = 280;
var mass:float = 540;
var velocity:Vector2 = Vector2(0, 0);
var MU_AIR:float = 0.001;
var MU_H:float = 0.06;


func _input(event):
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y -= jump_force;
		emit_signal("jumped");

func _physics_process(delta):
	#horizontal movement
	#if is_on_floor():
	if Input.is_action_pressed("ui_left"):
		velocity.x -= hforce;
	if Input.is_action_pressed("ui_right"):
		velocity.x += hforce;
	
	#gravity
	velocity.y += mass*delta;
	
	#air resistance
	velocity.x -= MU_AIR*velocity.x;
	velocity.y -= MU_AIR*velocity.y;
	#var v2 = velocity.x;
	
	#horizontal resistance
	velocity.x -= MU_H*velocity.x;
	#var v3 = velocity.y;

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
		grounded = true;
	else:
		if grounded:
			emit_signal("airborned");
		grounded = false;
