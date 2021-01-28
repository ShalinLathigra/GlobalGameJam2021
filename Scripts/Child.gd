extends KinematicBody2D


export var following_player = true;
export var speed = 7;
export var dist = 70;

var parent_node = null
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):

	if following_player:
		set_collision_mask_bit (0, false)
		if parent_node != null:
			if (parent_node - position).length() > dist:
				position += (parent_node - position).normalized() * speed	
		# position += (parent_node.position - position).normalized() * speed

func follow_node(node):
	parent_node = node
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
