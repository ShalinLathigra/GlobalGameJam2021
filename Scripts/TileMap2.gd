extends TileMap

export (NodePath) var wall_map
var WALL_INDEX = 11
var WALL_IMAGE_INDEX = 10
var wall_offset = Vector2(2, 2)

func _ready():
	get_wall_cells(get_node(wall_map))
	
func get_wall_cells(map):
	for tile_position in get_used_cells():
		if get_cellv(tile_position) == WALL_INDEX:
			map.set_cellv(tile_position - wall_offset, WALL_IMAGE_INDEX)
