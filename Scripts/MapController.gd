extends Node2D

const maps = [
	preload("res://Scenes/Testing/Map_01.tscn")
	]
export (NodePath) var cam;
export (NodePath) var test_map;

func _ready():
	var map_i = maps[0].instance()
	add_child(map_i)
	
	if (get_node(cam)):
		get_node(cam).set_walls(map_i)
	get_node(test_map).queue_free()
