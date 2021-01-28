extends Camera2D

export (NodePath) var player;

var map = null

func _process(delta):
	var screen_pos = Vector2(
		get_node(player).get_global_transform_with_canvas().origin.x / OS.get_window_size().x,
		get_node(player).get_global_transform_with_canvas().origin.y / OS.get_window_size().y
	);
	if (map.get_node("Walls")):
		map.get_node("Walls").material.set_shader_param("target", screen_pos)


func set_walls(wall):
	map = wall
