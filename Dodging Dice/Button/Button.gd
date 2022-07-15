extends StaticBody2D

signal pressed;
onready var button_head:Node = $"Button Head";
var weight:float = 0;
var threshold:float = 6;
var pressed:bool = false;
var start_y:float = -5;
var end_y:float = 5;
var button_range:float = abs(end_y-start_y);

func _process(delta):
	button_head.y = max(end_y, start_y + weight/threshold*button_range);
