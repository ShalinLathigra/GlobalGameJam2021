extends Node

enum item_type {FLOWER}

onready var image_map = {
	item_type.FLOWER: preload("res://Imports/Items/Flowers.png")
}
const item_map = {
	item_type.FLOWER: preload("res://Scenes/Components/Item.tscn")
}
