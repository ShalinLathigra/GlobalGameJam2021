extends Node2D

const maps = [
	preload("res://Scenes/Maps/Map_01.tscn"),
	preload("res://Scenes/Maps/Map_02.tscn"),
	#preload("res://Scenes/Maps/Map_11.tscn")
	#preload("res://Scenes/Maps/Map_02.tscn")
	#preload("res://Scenes/Maps/Map_12.tscn")
	#preload("res://Scenes/Maps/Map_03.tscn")
	#preload("res://Scenes/Maps/Map_13.tscn")
	]
	
enum map_indices {MORNING_01, MORNING_02}
export (map_indices) var i
	
export (NodePath) var cam;
export (NodePath) var map_path;

var available_items = []
var kids = []
var current_map = null

var kid_spawn_timer = 0.0
var kids_alive = 0.0

func _ready():
	randomize()
	_update_map()
	
func _update_map():
	if (get_node(map_path)):
		get_node(map_path).queue_free()
	
	var new_map = maps[i].instance()
	add_child(new_map)
	map_path = new_map.name
	current_map = new_map
	
	if (get_node(cam)):
		get_node(cam).set_walls(new_map)
	
	available_items = []
	for x in new_map.get_children():
		if "Shop" in x.name:
			for y in x.get_children():
				if "Shop" in y.name:
					available_items.push_back(y.type)
					
	_free_kids();
	_ready_kids()
	
func _free_kids():
	for x in self.kids:
		if (x):
			x.queue_free()
	get_node("/root/Node2D/Player").children = {}
		
func _ready_kids():
	kid_spawn_timer = 0.0
	kids_alive = 0.0
	for x in get_node(map_path).get_children():
		if "Children" in x.name:
			for y in x.get_children():
				if "Child" in x.name:
					kids.push_back(y)

func _input(event):
	if (Input.is_action_just_pressed("next_map")):
		i += 1
		i %= map_indices.size()
		_update_map()


func _spawn_rand_kid():
	var item_type = available_items[randi() % available_items.size()]
	var item = current_map.find_node("Shops").find_node("Shop*").get_item(item_type)
	kids.shuffle()
	for k in kids:
		if k.world_state == Child.STATE.NOT_SPAWNED:
			kids_alive += 1
			k.spawn_kid(item)
			return

func _process(delta):
	kid_spawn_timer += delta
	
	# kids should spawn during first x seconds of level
	var kid_wait_time = (current_map.SPAWN_TIME / current_map.MAX_KIDS)
	
	if kids_alive < current_map.MAX_KIDS:
		if kid_spawn_timer > kid_wait_time:
			_spawn_rand_kid()
			kid_spawn_timer = 0.0
