extends Node2D
class_name Map

export var MAX_KIDS = 5 # how many kids can spawn
export var KID_NEEDINESS = 30 # how quickly the kids change state
export var LEVEL_MAX_TIME = 180 # how long the level lasts
export var SPAWN_TIME = 30

var WALL_INDEX = 11
var WALL_IMAGE_INDEX = 10
var wall_offset = Vector2(2, 2)
func _ready():
	set_wall_cells()
	
func set_wall_cells():
	for tile_position in $Floor.get_used_cells():
		if $Floor.get_cellv(tile_position) == WALL_INDEX:
			$Walls.set_cellv(tile_position - wall_offset, WALL_IMAGE_INDEX)
