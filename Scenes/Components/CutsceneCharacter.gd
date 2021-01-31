extends AnimatedSprite

export (Color) var chat_color = Color.white
export var text_fade_in = 1.0
export var text_fade_out = 1.5
	
func _set_text(text):
	$TextBox/TextBox.text = text
	$TextBox/TextBox.visible_characters = 0
	print("%s: %s" % [name, $TextBox/TextBox.text])
	active = true
	
func _ready():
	$TextBox.modulate = chat_color
	$TextBox.modulate.a = 0.0
	
func is_done():
	return $TextBox/TextBox.visible_characters >= $TextBox/TextBox.get_total_character_count()
	
onready var time_of_last_char = OS.get_ticks_msec()
var msec_to_next_char = 10

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
	#if (!done and revealed < text.length() and revealed != -1 and $TextBox.modulate.a > 0.95):
	#	revealed += 1
#		$TextBox/TextBox.visible_characters = revealed
		
#	if (revealed == text.length()):
	#	done = true
		
	"""
	The scene will have a reference to each of the child objects that can be manipulated
	Characters and Text Boxes will be linked.
	Text boxes will maintain position above their targeted characters.
	
	The Scene will control which text box is active.
	Player input (Space Bar) will skip to end of current line, then pressing again will tell scene to go to next line.
	
	
	 will store behaviours like so:
			{
				id : 
				{
					Character : path, 
					Animation : name of Anim,
					event_type : one of [Talk, Gesture, Move, Pause],
					pause_info : 
						{
							duration : float
						}
					talk_info : 
						{
							dialogue : string,
						}
					gesture_info : 
						{
							transform_anim : name of Animation Player animation type
						}
					move_info : 
						{
							pos_flags : [start, pos_1, pos_2, ..., end] # Move Rate will be locked at walk speed.
							speed_flags : [start->1, 1->2, 2->3, 3->end] # Move at speed towards position
							# Skipping here will directly set position to last position & skip the rest.
						}
				}
			}
			
			
			
			CutSceneController
	"""
	pass
