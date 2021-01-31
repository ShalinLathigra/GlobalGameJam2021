extends Node2D

export (NodePath) var CC
export (NodePath) var MC
export (NodePath) var OC

onready var lines = {
	0:scene_1(),
}


var current_node = null
var i = 0
var j = 0
var playing = false

var max_start_timer = 3.0
var start_timer = max_start_timer

func set_lines(k):
	i = k
	
func is_done():
	return done
	
onready var done = false
var end_timer = 3.0

func _process(delta):
	if (lines.has(i)):
		if (j < lines[i].size()):
			if (!playing):
				start_timer = max (start_timer - delta, 0.0)
				if (start_timer <= 0.0):
					current_node = get_node(lines[i][j]["Node"])
					if (current_node):
						current_node._set_text(lines[i][j]["Line"])
						start_timer = max_start_timer
						playing = true
						j += 1
		else:
			if (end_timer <= 0.0):
				self.done = true
			else:
				end_timer -= delta
	else:
		self.done = true
			
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



func scene_1():
	return [
	{
		"Node" : CC,
		"Line" : "Hey you, you're finally awake",
		"Type" : "Text"
	},
	{
		"Node" : CC,
		"Line" : "Heck yeah you are",
		"Type" : "Text"
	},
	{
		"Node" : MC,
		"Line" : "I am indeed awoke",
		"Type" : "Text"
	},
	{
		"Node" : OC,
		"Line" : "Awwwww heck, me too!!!!",
		"Type" : "Text"
	}
]

