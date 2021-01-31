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
	item_type.PIZZA: preload("res://Resources/Items/Pizza.tres"),
	item_type.BANANA: preload("res://Resources/Items/Banana.tres"),
	item_type.BURGER: preload("res://Resources/Items/Burger.tres"),
	item_type.DONUT: preload("res://Resources/Items/Donut.tres"),
	item_type.EGG: preload("res://Resources/Items/Egg.tres"),
	item_type.COFFEE: preload("res://Resources/Items/Coffee.tres")
}
const item_base = preload("res://Scenes/Components/Item.tscn")

enum item_type {APPLE, CARROT, CHEESE, CHOCOLATE, FLOWERS, ICECREAM, MILK, PIZZA, BANANA, BURGER, DONUT, EGG, COFFEE}

export (item_type) var type
export (Vector2) var override_scale = Vector2(1.0, 1.0)

func _ready():
	$Sprite.texture = image_map[type]
	$Sprite.scale = override_scale
	$AnimationPlayer.play("Idle")

func get_item(type):
	var item = item_base.instance()
	item.texture = image_map[type]
	item.type = type
	item.scale = override_scale * 0.9
	return item


func _on_Shop_body_entered(body):
	if(type==item_type.COFFEE):
		body.coffee_timer = body.max_coffee_timer
	
	elif (!body.is_holding(type)):
		var item = get_item(type)
		body.set_item(item)

