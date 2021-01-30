extends Node2D

export (NodePath) var CC
export (NodePath) var MC
export (NodePath) var OC

onready var lines = [
	{
		"Node" : CC,
		"Line" : "Hey you, you're finally awake",
		"Type" : "Text"
	},
	{
		"Node" : CC,
		"Line" : "FUCK FUCK FUCK FUCK",
		"Type" : "Text"
	},
	{
		"Node" : MC,
		"Line" : "Hey you, you're finally DUMB",
		"Type" : "Text"
	},
	{
		"Node" : OC,
		"Line" : "Hey you, you're finally DUMBER",
		"Type" : "Text"
	}
]

var current_node = null
var i = 0
var playing = false

var max_start_timer = 3.0
var start_timer = max_start_timer

func set_lines(arr):
	lines = arr
	
func is_done():
	return done
	
onready var done = false
var end_timer = 3.0

func _process(delta):
	if (i < lines.size()):
		if (!playing):
			start_timer = max (start_timer - delta, 0.0)
			if (start_timer <= 0.0):
				current_node = get_node(lines[i]["Node"])
				current_node._set_text(lines[i]["Line"])
				start_timer = max_start_timer
				playing = true
				i += 1
	else:
		if (end_timer <= 0.0):
			self.done = true
		else:
			end_timer -= delta
			
func _input(event):
	if (Input.is_action_just_released("ui_accept")):
		if (playing):
			if(current_node):
				if (current_node.is_done()):
					current_node.complete()
					playing = false
				else:
					current_node.skip()
		else:
			start_timer = 0.0
