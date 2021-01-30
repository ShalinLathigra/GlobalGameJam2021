extends KinematicBody2D
class_name Player

enum PLAYER_STATE {WALK, RUN, IDLE}
enum PLAYER_DIR {LEFT, RIGHT}

export var run_speed = 600
export var accel = 300
var friction = 0.9
var vel = Vector2()

var anim = PLAYER_STATE.IDLE
var direction = PLAYER_DIR.LEFT

var children = {}
var moving = false

func _ready():
	randomize()
	pass

onready var item = null
	
func _physics_process(_delta):
	var dir = Vector2()
	moving = false
	
	if Input.is_action_pressed("UP"):
		dir.y = -1
		moving = true
	elif Input.is_action_pressed("DOWN"):
		dir.y = 1
		moving = true
	if Input.is_action_pressed("LEFT"):
		dir.x = -1
		direction = PLAYER_DIR.LEFT
		moving = true
	elif Input.is_action_pressed("RIGHT"):
		dir.x = 1
		direction = PLAYER_DIR.RIGHT
		moving = true
	
	var max_speed = run_speed
	
	if moving:
		if Input.is_action_pressed("WALK"):
			anim = PLAYER_STATE.WALK
			max_speed *= 0.6
		else:
			anim = PLAYER_STATE.RUN
	else:
		anim = PLAYER_STATE.IDLE
		
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
	if (self.item):
		if (vel.x < 0):
			self.item.position.x = -1.0 * $Anchor.position.x
		else:
			self.item.position.x = $Anchor.position.x
			
		if (vel.length_squared() == 0.0):
			self.item.material.set_shader_param("jitter", 0.0)
		else:
			self.item.material.set_shader_param("jitter", vel.length() / run_speed)
			
	
func link_children():
	var z_val = 25 # max number of children
	if !children.empty():
		var prev_child = self
		for child_key in children:
			var child = children[child_key]
			child.follow_node(prev_child, z_val)
			prev_child = child
			z_val -= 1

func remove_child(child_name):
	children.erase(child_name)
	link_children()

func _on_Area2D_body_entered(body):
	if "Child" in body.name:
		if !children.has(body.name):
			children[body.name] = body
			link_children()
func set_item(item):
	if (self.item):
		self.item.type = item.type
		self.item.texture = item.texture
		self.item.scale = item.scale
	else:
		item.position = $Anchor.position
		add_child(item)
		self.item = item
		

func is_holding(type):
	print(type)
	if (self.item):
		return self.item.type == type
	return false
