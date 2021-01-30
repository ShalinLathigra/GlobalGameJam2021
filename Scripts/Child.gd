extends KinematicBody2D
class_name Child

const child_a = preload("res://Resources/Child1.tres")
const child_b = preload("res://Resources/Child2.tres")

enum HAPPINESS {HAPPY, NEUTRAL, VERY_UNHAPPY}
enum STATE {NOT_SPAWNED, IDLE, FOLLOWING_PLAYER, RUNNING}

export var speed = 450; # how fast the child moves towards parent
export var dist = 70; # how close the child is before it stops moving
export var run_dist = 100; # distance child needs to be before it starts running


var tick_time = 15.0
var timer = 0.0

var parent_node = null
var was_moving = false
var moving = false

var happy_state = HAPPINESS.NEUTRAL
var world_state = STATE.IDLE # TODO
var current_desire = Shop.item_type.APPLE

onready var item = null

func _setup_sprite():
	var gender = (randi() % 2) == 1
	var sprite = $AnimatedSprite
	if gender:
		sprite.frames = child_a
	else:
		sprite.frames = child_b
	
	var r = float(randi() % 256) / 256.0
	var g = float(randi() % 256) / 256.0
	var b = float(randi() % 256) / 256.0
	
	var shirt_color = Vector3(r, g, b)
	
	sprite.material.set_shader_param("input_color", shirt_color)	
	sprite.material.set_shader_param("gender", gender)

func _ready():
	_setup_sprite()

func switch_anim(anim):
	var sprite = get_node("AnimatedSprite")
	if sprite.animation != anim:
		sprite.animation = anim


func _following_player():
	set_collision_mask_bit (0, false)
	if parent_node != null:
		if (parent_node.position - position).length() < dist:
			moving = false
			switch_anim("idle")
		if (parent_node.position - position).length() > run_dist:
			moving = true
			switch_anim("run")
		if moving:
			_move_towards_parent()

func _move_towards_parent():
	move_and_slide((parent_node.position - position).normalized() * speed)
	if parent_node.position.x < position.x:
		get_node("AnimatedSprite").flip_h = true
	else:
		get_node("AnimatedSprite").flip_h = false

func _physics_process(delta):
	$AnimatedSprite.visible = true
	
	match world_state:
		STATE.FOLLOWING_PLAYER:
			_following_player()
		STATE.IDLE:
			pass
		STATE.NOT_SPAWNED:
			$AnimatedSprite.visible = false

func _tick_time(delta):
	timer += delta
	if timer > tick_time:
		timer = 0.001
		match happy_state:
			HAPPINESS.HAPPY:
				happy_state = HAPPINESS.NEUTRAL
			HAPPINESS.NEUTRAL:
				happy_state = HAPPINESS.VERY_UNHAPPY
			HAPPINESS.VERY_UNHAPPY:
				print("UH_OH") # TODO

func _update_item_sprite():
	match happy_state:
		HAPPINESS.HAPPY:
			if (self.item):
				self.item.visible = false
		HAPPINESS.NEUTRAL:
			if (self.item):
				self.item.visible = true
				
				if (timer > 0):
					self.item.material.set_shader_param("jitter", 1.0)
				else:
					self.item.material.set_shader_param("jitter", 0.0)
				self.item.material.set_shader_param("jitter_period", 0.2 + timer/tick_time)
		HAPPINESS.VERY_UNHAPPY:
			if (self.item):
				self.item.visible = true
				self.item.material.set_shader_param("jitter", 1.0)
				self.item.material.set_shader_param("jitter_period", 1.2 + timer/tick_time)
				self.item.material.set_shader_param("color_red", 1.0)

func _process(delta):
	match world_state:
		STATE.FOLLOWING_PLAYER:
			_tick_time(delta)
			_update_item_sprite()
		_:
			self.item.visible = false

func follow_me():
	world_state = STATE.FOLLOWING_PLAYER

# tell the child to follow the player (or line of kids)
func follow_node(node, z_val):
	world_state = STATE.FOLLOWING_PLAYER
	parent_node = node
	z_index = z_val

func give_item(item):
	if item == null:
		return false
	if item.type == self.item.type:
		world_state = STATE.FOLLOWING_PLAYER
		happy_state = HAPPINESS.HAPPY
		return true
	return false	

func set_item(item):
	if (self.item):
		self.item.type = item.type
		self.item.texture = item.texture
		self.item.scale = item.scale
	else:
		item.position = $Anchor.position
		add_child(item)
		self.item = item
	self.item.material.set_shader_param("jitter", 0.0)
# 
func spawn_kid(item):
	current_desire = item.type
	set_item(item)
	world_state = STATE.IDLE
	happy_state = HAPPINESS.NEUTRAL
