extends Node2D

export (NodePath) var CC
export (NodePath) var MC

onready var scenes = {
	0:morn_1(),
	1:lunch_1(),
	2:end_1(),
	3:morn_2(),
	4:lunch_2(),
	5:end_2()
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
	0:morn_1(),
	1:lunch_1(),
	2:end_1(),
	3:morn_2(),
	4:lunch_2(),
	5:end_2()
		}
		
	if (self.scenes.has(i)):
		scene = self.scenes[i]
		lines = scene["Lines"]
		
		get_node(CC).position = Vector2(scene["Positions"]["CC"].x,scene["Positions"]["CC"].y)
		get_node(MC).position = Vector2(scene["Positions"]["MC"].x,scene["Positions"]["MC"].y)
		
		get_node(CC).z_index = scene["Positions"]["CC"].z
		get_node(MC).z_index = scene["Positions"]["MC"].z
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
					current_node = get_node(lines[j]["Node"])
					if (current_node):
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



func morn_1():
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
					"Line" : "It pays. Not a fan of being a babysitter",
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
				}
		}




func lunch_1():
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
					"Line" : "Mmmmm.",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "I think know what you need.",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "What?",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Your coffee",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Mmm thanks........... Did you put sugar in this?",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "I don't know, did I?",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Think your time’s up for chit chat, your shift’s soon.",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Right...",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Come by whenever you want another pick me up~",
					"Type" : "Text"
				},
			],
			"Positions" : 
				{
				"MC" : Vector3(100,-210,500),
				"CC" : Vector3(17, -250, 2),
				}
		}



func end_1():
	return {
		"Lines":
			[
				{
					"Node" : CC,
					"Line" : "Congrats on another shift!",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Thanks.......... Jeez these kids are something else",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Mhmmmm.......... How was your coffee?",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Oh uh… Not bad I guess.",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Heh. Coming from ‘I love nothing but black’ all the time.",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "It’s a lifestyle. Sugar’s just too…",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Pfft whatever you say.",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Anyways, you better start locking up now. It’s closing time.",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Right right… See you tomorrow.",
					"Type" : "Text"
				},
			],
			"Positions" : 
				{
				"MC" : Vector3(100,-210,500),
				"CC" : Vector3(17, -250, 2),
				}
		}





func morn_2():
	return {
		"Lines":
			[
				{
					"Node" : CC,
					"Line" : "Rise and shine sleepyhead!",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Ready for another funtastic shift?",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Er… Yeah I guess so.",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Could I get a coffee please?",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Of course. How’d you like it?",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "With suga-AHEM......... Black please.",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Mmmm, alright. Whatever ya say.",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "One ‘black’ coffee. On the house just for you.",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Th-thanks.",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Have fun on your shift. I’ll be here whenever ya want another pick me up.",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Yeah. I'll come by.",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "........ She put sugar in this...",
					"Type" : "Text"
				},
			],
			"Positions" : 
				{
				"MC" : Vector3(100,-210,500),
				"CC" : Vector3(17, -250, 2),
				}
		}


func lunch_2():
	return {
		"Lines":
			[
				{
					"Node" : CC,
					"Line" : "Coffee again?",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Yes please.",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "You're halfway done for today, but...",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "But what?",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "I heard there’s a school bus full of kids coming here for a field trip.",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "...",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "You want that coffee to be a large?",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Preferably.",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Extra sugar and milk, my treat.",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Ah that’s not necessary-",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Sorry what’s that? One extra large coffee with milk and sugar?",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Oh would you look at the time! Your shift’s starting.",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Come by whenever ya want another pick me up. Have fun~",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "...Here we go then.",
					"Type" : "Text"
				},
			],
			"Positions" : 
				{
				"MC" : Vector3(100,-210,500),
				"CC" : Vector3(17, -250, 2),
				}
		}


func end_2():
	return {
		"Lines":
			[
				{
					"Node" : MC,
					"Line" : "Well here we are again.",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Yup yup.",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Congrats on surviving your the school trip.",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "How was my coffee?",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Ah.... Erm.",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Sorry what was that?",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Not bad...",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "See what I mean? You need a little milk in sugar in your life.",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Anyways time for lock up isn’t it?",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Yeah, right.......",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "You want one last cup for the night?",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "If you wouldn’t mind.",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Heh, on the house again just for you.",
					"Type" : "Text"
				},
				{
					"Node" : CC,
					"Line" : "Here’s your coffee..",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "...",
					"Type" : "Text"
				},
				{
					"Node" : MC,
					"Line" : "Y’know, maybe this job isn’t so bad.",
					"Type" : "Text"
				},
			],
			"Positions" : 
				{
				"MC" : Vector3(100,-210,500),
				"CC" : Vector3(17, -250, 2),
				}
		}
