extends Node2D

var audio_credits = false


func _process(delta):
	if (Input.is_action_just_released("ui_accept")):
		audio_credits = !audio_credits

	if audio_credits:
		$ColorRect/RichTextLabel.visible = false
		$ColorRect/AudioCredits.visible = true
	else:
		$ColorRect/RichTextLabel.visible = true
		$ColorRect/AudioCredits.visible = false
