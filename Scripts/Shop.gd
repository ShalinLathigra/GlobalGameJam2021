extends Area2D
class_name Shop


onready var image_map = {
	item_type.FLOWER: preload("res://Imports/Items/Flowers.png")
}
onready var item_map = {
	item_type.FLOWER: preload("res://Scenes/Components/Item.tscn")
}

enum item_type {FLOWER}

export (item_type) var type

func _ready():
	$Sprite.texture = image_map[type]

func _on_Shop_body_entered(body):
	body.set_item(item_map[type].instance())
