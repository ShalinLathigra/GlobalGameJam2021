extends KinematicBody2D

export var run_speed = 600
export var accel = 300
var friction = 0.9
var vel = Vector2()

var anim = "IDLE"
var direction = 'L'

var children = {}
var moving = false

func _ready():
	randomize()
	pass

func _physics_process(_delta):
	var dir = Vector2()
	moving = false
	
	if Input.is_action_pressed("UP"):
		dir.y = -1
		#if vel.y < 0: 
		#	vel.y = -vel.y
		moving = true
	elif Input.is_action_pressed("DOWN"):
		dir.y = 1
		#if vel.y > 0: 
		#	vel.y = -vel.y
		moving = true
	if Input.is_action_pressed("LEFT"):
		dir.x = -1
		#if vel.x < 0: 
		#	vel.x = -vel.y
		direction = 'L'
		moving = true
	elif Input.is_action_pressed("RIGHT"):
		dir.x = 1
		#if vel.x > 0: 
		#	vel.x = -vel.y
		direction = 'R'
		moving = true
	
	var max_speed = run_speed
	
	if moving:
		if Input.is_action_pressed("WALK"):
			anim = "WALK"
			max_speed *= 0.6
		else:
			anim = "RUN"
	else:
		anim = "IDLE"
		
	dir = dir.normalized()
	vel += dir * accel
	
	if vel.length() > max_speed:
		vel = vel.normalized() * max_speed

	vel = move_and_slide(vel)
	if !moving:
		vel = (1 - friction) * vel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	get_node("AnimatedSprite").play_anim(anim, direction)
	
func link_children():
	var z_val = 25 # max number of children
	if !children.empty():
		var prev_child = self
		for child_key in children:
			var child = children[child_key]
			child.follow_node(prev_child, z_val)
			prev_child = child
			z_val -= 1

func _on_Area2D_body_entered(body):
	if "Child" in body.name:
		if !children.has(body.name):
			children[body.name] = body
			link_children()

func set_item(item):
	item.position = Vector2(10, 0.0)
	add_child(item)
	print(item)
