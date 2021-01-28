extends AnimatedSprite

func play_anim(animName, dir):
	
	if dir == 'L':
		flip_h = true
	else:
		flip_h = false		
	
	if animName == "IDLE":
		if animation != "idle":
			play("idle")
	if animName == "RUN":
		if animation != "run":
			play("run")
	if animName == "WALK":
		if animation != "walk":
			play("walk")
