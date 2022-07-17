extends Control

onready var coin_bar:Node = $"TextureProgress";
onready var coin_bar_x0:float = coin_bar.rect_position.x;
onready var label:Node = $"Text Box/Label";
var digit_width:float = 10;
var extra_width:float = 21;
onready var offset_width:float = extra_width - coin_bar_x0;
var scaling:bool = false;
var angle_current:float = 0;
var angle_end:float = 0;
var k:float = 0;
var scale_speed:float = 0.05;

func _process(delta):
	if scaling:
		self.rect_scale.x = k*sin(angle_current);
		self.rect_scale.y = self.rect_scale.x;
		angle_current += scale_speed;
		if angle_current >= angle_end:
			scaling = false;

func scale(n):
	angle_current = n;
	angle_end = PI - n;
	k = 1/sin(angle_current);
	scaling = true;

func set_coin_count(n, pop):
	var d:int = digit_count(n);
	#move and extend coin bar
	coin_bar.rect_position.x = coin_bar_x0 + (d-1)*digit_width;
	var exposed_width:float = coin_bar.rect_position.x + offset_width;
	coin_bar.set_value(exposed_width);
	
	label.text = str(n);
	if pop:
		scale(1.2);

func digit_count(n):
	var ans:int = 1;
	while n >= 10:
		n /= 10;
		ans += 1;
	return ans;
