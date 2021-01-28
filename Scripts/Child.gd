extends KinematicBody2D


export var following_player = true; # 
#export var speed = 7; # how fast the child moves towards parent
export var speed = 400;
export var dist = 70; # how close the child is before it stops moving
export var run_dist = 100;

var parent_node = null
var was_moving = false
var moving = false

var child_version = 0

const child_a = preload("res://Resources/Child1.tres")
const child_b = preload("res://Resources/Child2.tres")

func _ready():
	var gender = randi() % 2
	var sprite = get_node("AnimatedSprite")
	if gender == 1:
		sprite.frames = child_a
	else:
		sprite.frames = child_b	


func switch_anim(anim):
	var sprite = get_node("AnimatedSprite")
	if sprite.animation != anim:
		sprite.animation = anim


func _move_towards_parent():
	move_and_slide((parent_node.position - position).normalized() * speed)
	if parent_node.position.x < position.x:
		get_node("AnimatedSprite").flip_h = true
	else:
		get_node("AnimatedSprite").flip_h = false

func _physics_process(delta):

	if following_player:
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
				#if !parent_node.moving:
				#	moving = false
				#	switch_anim("idle")
				#if was_moving:
				#	was_moving = false
				#else:
				#	switch_anim("idle")
	else:
		print("CHILD_IDLE")

func follow_node(node, z_val):
	parent_node = node
	z_index = z_val
