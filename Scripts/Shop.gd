extends Area2D
class_name Shop
export (Globals.item_type) var type;
var item = Globals.item_map[type]

func _ready():
	$Sprite.texture = Globals.image_map[type]
	item = Globals.item_map[type].instance()

func _on_Shop_body_entered(body):
	body.set_item(item)
