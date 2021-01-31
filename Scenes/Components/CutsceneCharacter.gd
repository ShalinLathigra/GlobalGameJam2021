extends AnimatedSprite

export (Color) var chat_color = Color.white
export var text_fade_in = 2.0
export var text_fade_out = 3.0
	
func _set_text(text):
	$TextBox/TextBox.text = text
	$TextBox/TextBox.visible_characters = 0
	active = true
	
func _ready():
	$TextBox.modulate = chat_color
	$TextBox.modulate.a = 0.0
	
func is_done():
	return $TextBox/TextBox.visible_characters >= $TextBox/TextBox.get_total_character_count()
	
onready var time_of_last_char = OS.get_ticks_msec()
var msec_to_next_char = 50

var active = false

func complete():
	active = false	
	
func skip():
	$TextBox/TextBox.visible_characters = $TextBox/TextBox.get_total_character_count()
	$TextBox.modulate.a = 1.0
	pass

func _process(delta):
	if (active):
		$TextBox.modulate.a = min($TextBox.modulate.a + delta * text_fade_in, 1.0)
		if (OS.get_ticks_msec() > self.time_of_last_char + msec_to_next_char and $TextBox.modulate.a > 0.95):
			$TextBox/TextBox.visible_characters += 1
			self.time_of_last_char = OS.get_ticks_msec()
				
	else: 
		$TextBox.modulate.a = max($TextBox.modulate.a - delta * text_fade_out, 0.0)
	pass
