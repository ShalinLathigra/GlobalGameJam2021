extends KinematicBody2D
class_name Child

const child_a = preload("res://Resources/Child1.tres")
const child_b = preload("res://Resources/Child2.tres")

export var speed = 450; # how fast the child moves towards parent
export var dist = 70; # how close the child is before it stops moving
export var run_dist = 100; # distance child needs to be before it starts running

var parent_node = null
var was_moving = false
var moving = false

enum {HAPPY, NEUTRAL, VERY_UNHAPPY}
enum {NOT_SPAWNED, IDLE, FOLLOWING_PLAYER, RUNNING}

var happy_state = HAPPY
var world_state = IDLE # TODO
var current_desire = 0

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
		FOLLOWING_PLAYER:
			_following_player()
		IDLE:
			pass
		NOT_SPAWNED:
			$AnimatedSprite.visible = false
			

# tell the child to follow the player (or line of kids)
func follow_node(node, z_val):
	world_state = FOLLOWING_PLAYER
	parent_node = node
	z_index = z_val

# 
func spawn_kid(desire):
	current_desire = desire
	world_state = IDLE
	
