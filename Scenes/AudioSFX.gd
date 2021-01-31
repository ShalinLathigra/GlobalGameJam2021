extends AudioStreamPlayer
class_name AudioSFX

const audio_list = [
	preload("res://SFX/child_found.wav"),
	preload("res://SFX/child_lost.wav"),
	preload("res://SFX/get_item.wav"),
	preload("res://SFX/lose.wav"),
	preload("res://SFX/win.wav")
	]

enum sfx {CHILD_FOUND, CHILD_LOST, GET_ITEM, LOSE, WIN}

func play_sfx(fx_name):
	self.stream = audio_list[fx_name]
	self.play()
