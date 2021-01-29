extends Area2D
class_name Shop


onready var image_map = {
	item_type.APPLE: preload("res://Resources/Items/Apple.tres"),
	item_type.CARROT: preload("res://Resources/Items/Carrot.tres"),
	item_type.CHEESE: preload("res://Resources/Items/Cheese.tres"),
	item_type.CHOCOLATE: preload("res://Resources/Items/Chocolate.tres"),
	item_type.FLOWERS: preload("res://Resources/Items/Flowers.png"),
	item_type.ICECREAM: preload("res://Resources/Items/IceCream.tres"),
	item_type.MILK: preload("res://Resources/Items/Milk.tres"),
	item_type.PIZZA: preload("res://Resources/Items/Pizza.tres")
}
const item_base = preload("res://Scenes/Components/Item.tscn")

enum item_type {APPLE, CARROT, CHEESE, CHOCOLATE, FLOWERS, ICECREAM, MILK, PIZZA}

export (item_type) var type

func _ready():
	$Sprite.texture = image_map[type]

func _on_Shop_body_entered(body):
	if (!body.is_holding(type)):
		var item = item_base.instance()
		item.texture = image_map[type]
		item.type = type
		body.set_item(item)
