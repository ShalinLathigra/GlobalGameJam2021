extends Node2D

var WALL_INDEX = 11
var WALL_IMAGE_INDEX = 10
var wall_offset = Vector2(2, 2)
	
func _ready():
	set_wall_cells()
	
func set_wall_cells():
	for tile_position in $Floor.get_used_cells():
		if $Floor.get_cellv(tile_position) == WALL_INDEX:
			$Walls.set_cellv(tile_position - wall_offset, WALL_IMAGE_INDEX)
