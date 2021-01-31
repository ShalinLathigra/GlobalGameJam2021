extends Node2D

const scene_list = [
	preload("res://Scenes/Maps/CutSceneMap.tscn"),
	preload("res://Scenes/Maps/Map_01.tscn"),
	preload("res://Scenes/Maps/Map_02.tscn"),
	preload("res://Scenes/Maps/Map_03.tscn"),
	#preload("res://Scenes/Maps/Map_11.tscn")
	#preload("res://Scenes/Maps/Map_02.tscn")
	#preload("res://Scenes/Maps/Map_12.tscn")
	#preload("res://Scenes/Maps/Map_03.tscn")
	#preload("res://Scenes/Maps/Map_13.tscn")
	preload("res://Scenes/Maps/WIN.tscn"),
	]

enum scene_indices {CUTSCENE, MAP_01, MAP_02, MAP_03, WIN}
#export (scene_indices) var i

var i = 0

var scene_order = [
	scene_indices.CUTSCENE,
	scene_indices.MAP_01,
	scene_indices.CUTSCENE,
	scene_indices.MAP_02,
	scene_indices.CUTSCENE,
	scene_indices.MAP_03,
	scene_indices.CUTSCENE,
	scene_indices.WIN
	]

export (NodePath) var cam;
export (NodePath) var scene_path;
export (NodePath) var player;

var available_items = []
var kids = []
var current_scene = null

var kid_spawn_timer = 0.0
var kids_alive = 0
var kids_lost = 0

func _ready():
	randomize()
	_update_map()

var fade_timer = 0.0

var level_timer = 0.0

var cs = 0

func _update_map():
	if (get_node(scene_path)):
		get_node(scene_path).queue_free()

	var new_scene = scene_list[scene_order[i]].instance()
	if (scene_order[i] == scene_indices.CUTSCENE):
		get_node(player).visible = false
		new_scene.set_lines(cs)
	elif (scene_order[i] == scene_indices.WIN):
		get_node(player).visible = false
	else:
		get_node(player).visible = true
		get_node(player).position = Vector2(0,0)

	add_child(new_scene)
	scene_path = new_scene.name
	current_scene = new_scene

	if (get_node(cam)):
		get_node(cam).set_walls(new_scene)

	available_items = []
	for x in new_scene.get_children():
		if "Shop" in x.name:
			for y in x.get_children():
				if "Shop" in y.name:
					available_items.push_back(y.type)

	_free_kids()
	_ready_kids()

func _free_kids():
	for x in self.kids:
		if (x):
			x.queue_free()
	get_node("/root/Node2D/Player").children = {}

func _ready_kids():
	kid_spawn_timer = 0.0
	kids_alive = 0.0
	for x in get_node(scene_path).get_children():
		if "Children" in x.name:
			for y in x.get_children():
				if "Child" in y.name:
					y.tick_time = get_node(scene_path).KID_NEEDINESS
					kids.push_back(y)

func _input(event):
	if (Input.is_action_just_pressed("next_map")):
		i = min(scene_order.size() - 1, i + 1)
		_update_map()

func _spawn_rand_kid():
	var item_type = available_items[randi() % available_items.size()]
	var item = current_scene.find_node("Shops").find_node("Shop*").get_item(item_type)
	kids.shuffle()
	for k in kids:
		if (k):
			if k.world_state == Child.STATE.NOT_SPAWNED:
				kids_alive += 1
				k.spawn_kid(item)
				return

var game_over = false
var progress = false
func _process(delta):
	if (Input.is_action_pressed("Quit")):
		get_tree().quit()
	if (!game_over && !progress):
		if (scene_order[i] == scene_indices.CUTSCENE):
			if (current_scene.done == true):
				if (fade_timer < 1.0):
					fade_timer = min(fade_timer + delta, 1.0)
					$Fade.modulate.a = fade_timer
					if ($Player/Camera2D/FadeLabel.modulate.a > 0.0):
						$Player/Camera2D/FadeLabel.modulate.a = fade_timer
				else:
					i += 1
					i %= scene_order.size()
					_update_map()
			else:
				if (fade_timer > 0.0):
					fade_timer = max(fade_timer - delta, 0.0)
					$Fade.modulate.a = fade_timer
					if ($Player/Camera2D/FadeLabel.modulate.a > 0.0):
						$Player/Camera2D/FadeLabel.modulate.a = fade_timer
		elif (scene_order[i] == scene_indices.WIN):
			if (fade_timer > 0.0):
				fade_timer = max(fade_timer - delta, 0.0)
				$Fade.modulate.a = fade_timer
				if ($Player/Camera2D/FadeLabel.modulate.a > 0.0):
					$Player/Camera2D/FadeLabel.modulate.a = fade_timer
			pass
		else:
			if (fade_timer > 0.0):
				fade_timer = max(fade_timer - delta * 0.5, 0.0)
				$Fade.modulate.a = fade_timer
				if ($Player/Camera2D/FadeLabel.modulate.a > 0.0):
					$Player/Camera2D/FadeLabel.modulate.a = fade_timer
			kid_spawn_timer += delta

			# kids should spawn during first x seconds of level
			if (scene_order[i] != scene_indices.WIN):
				var kid_wait_time = (current_scene.SPAWN_TIME / current_scene.MAX_KIDS)

				if kids_alive < current_scene.MAX_KIDS:
					if kid_spawn_timer > kid_wait_time:
						_spawn_rand_kid()
						kid_spawn_timer = 0.0

				if (level_timer > current_scene.LEVEL_MAX_TIME):
					progress = true
				else:
					level_timer += delta
	else:
		if (fade_timer < 1.0):
			fade_timer = min(fade_timer + delta, 1.0)
			$Fade.modulate.a = fade_timer
			if (game_over):
				$Player/Camera2D/FadeLabel.modulate.a = fade_timer
		else:
			if (progress):
				i += 1
				if (scene_order[i] == scene_indices.CUTSCENE):
					cs += 1
			level_timer = 0.0
			game_over = false
			progress = false
			_update_map()

func lose_child(child):
	kids_lost += 1
	kids.erase(child)
	print(kids_lost)
	if (kids_lost >= 2):
		game_over = true
