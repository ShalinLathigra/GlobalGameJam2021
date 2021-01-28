extends Node2D

const maps = [
	preload("res://Scenes/Testing/Map_01.tscn"),
	preload("res://Scenes/Testing/Map_02.tscn")
	]
	
enum map_indices {MORNING_01, MORNING_02}
export (map_indices) var i
	
export (NodePath) var cam;
export (NodePath) var map_path;

func _ready():
	_update_map()
	
func _update_map():
	if (get_node(map_path)):
		get_node(map_path).queue_free()
	
	var new_map = maps[i].instance()
	add_child(new_map)
	map_path = new_map.name
	
	if (get_node(cam)):
		get_node(cam).set_walls(new_map)
		
	
func _input(event):
	if (Input.is_action_just_pressed("next_map")):
		i += 1
		i %= map_indices.size()
		_update_map()
