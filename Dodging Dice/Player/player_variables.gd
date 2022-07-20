extends Node

var level_coin_count:int = 0;
var total_coin_count:int = 0;
var position_saved:bool = false;
var saved_position:Vector2 = Vector2(0, 0);

func push_coin_count():
	total_coin_count += level_coin_count;
	level_coin_count = 0;
