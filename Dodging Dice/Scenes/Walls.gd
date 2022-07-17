extends TileMap

var room_tx:int = 32;
var room_ty:int = 20;
var die_values = create_array_int(room_tx, room_ty, 0);

func _init():
	die_values[6][4] = 5;
	die_values[19][12] = 6;
	die_values[21][18] = 2;

func create_array_int(x, y, value):
	var a = [];
	for i in range(x):
		var b = [];
		for j in range(y):
			b.append(value);
		a.append(b);
	return a;
