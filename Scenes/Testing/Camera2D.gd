extends Camera2D

export (NodePath) var walls;
export (NodePath) var player;

func _process(delta):
	#print(get_node(player).get_global_transform_with_canvas().origin)
	var screen_pos = Vector2(
		get_node(player).get_global_transform_with_canvas().origin.x / OS.get_window_size().x,
		get_node(player).get_global_transform_with_canvas().origin.y / OS.get_window_size().y
	);
	get_node(walls).material.set_shader_param("target", screen_pos)
