extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _process(delta):
	var game_controller = get_node("/root/Node2D")
	var cur_scene_type = game_controller.get_current_scene_type()
	if (cur_scene_type == MapController.scene_indices.CUTSCENE || cur_scene_type == MapController.scene_indices.WIN):
		return
	
	var level = game_controller.current_scene
	
	var max_time = int(level.LEVEL_MAX_TIME)
	var time = max_time - int(game_controller.level_timer)

	get_node("Time").set_text("Time: " + str(time))
	
	var max_kids = level.MAX_KIDS
	var kids = get_node("/root/Node2D/Player").children.size()
	
	get_node("Found").set_text("Found: " + str(kids) + "/" + str(max_kids))
	
	var lost = game_controller.kids_lost

	if lost == 0:
		get_node("Lost").set_text("")
	else:
		get_node("Lost").set_text("Lost: " + str(lost) + "/2")

#	pass
