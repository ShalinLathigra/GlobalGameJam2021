extends Node2D

export (NodePath) var CC
export (NodePath) var MC
export (NodePath) var OC

onready var scenes = {
	0:scene_1(),
	1:scene_2()
}

var lines = null
var scene = null


var current_node = null
var i = 0
var j = 0
var playing = false

var max_start_timer = 1.0
var start_timer = max_start_timer

func set_scene(k):
	i = k
	if (!self.scenes):
		self.scenes = {
			0:scene_1(),
			1:scene_2(),
		}
		
	if (self.scenes.has(i)):
		print(self.scenes)
		scene = self.scenes[i]
		lines = scene["Lines"]
		
		get_node(CC).position = Vector2(scene["Positions"]["CC"].x,scene["Positions"]["CC"].y)
		get_node(MC).position = Vector2(scene["Positions"]["MC"].x,scene["Positions"]["MC"].y)
		get_node(OC).position = Vector2(scene["Positions"]["OC"].x,scene["Positions"]["OC"].y)
		
		get_node(CC).z_index = scene["Positions"]["CC"].z
		get_node(MC).z_index = scene["Positions"]["MC"].z
		get_node(OC).z_index = scene["Positions"]["OC"].z
	else:
		scene = null
		lines = null
	
func is_done():
	return done
	
onready var done = false
var end_timer = 3.0

func _process(delta):
	if (!scene or !lines):
		self.done = true
	if (lines):
		if (j < lines.size()):
			if (!playing):
				start_timer = max (start_timer - delta, 0.0)
				if (start_timer <= 0.0):
					print(lines[j])
					#print(lines[j]["Node"])
					current_node = get_node(lines[j]["Node"])
					if (current_node):
						print("F")
						current_node._set_text(lines[j]["Line"])
						start_timer = max_start_timer
						playing = true
						j += 1
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



func scene_1():
	return {
		"Lines":
			[
				{
					"Node" : CC,
					"Line" : "Black coffee again?",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Please",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Coming right up.",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "...",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Not a fan of your job?",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "it pays. Not a fan of being a babysitter",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Well better get used to it. This is a mall after all",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Oh, by the way, did you hear the news?",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Nope, something happen?",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "My lil' sis is in town with her kids",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "They're Super Cute!",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Mmm.",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Well I definitely see you're not one for kids.",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Anyways, one black coffee. This one's on the house.",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "O-0h. Thanks",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Mmmhm, good luck on your shift. Come by if you want another pick me up.",
					"Type" : "Text"
				},
			],
			"Positions" : 
				{
				"MC" : Vector3(100,-210,500),
				"CC" : Vector3(17, -250, 2),
				"OC" : Vector3(-10000, -10000, 500),
				}
		}




func scene_2():
	return {
		"Lines":
			[
				{
					"Node" : CC,
					"Line" : "Black coffee again?",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Please",
					"Type" : "Text"
				},
			],
			"Positions" : 
				{
				"MC" : Vector3(100,-210,500),
				"CC" : Vector3(17, -250, 2),
				"OC" : Vector3(-10000, -10000, 500),
				}
		}

