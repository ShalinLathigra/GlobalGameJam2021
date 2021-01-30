extends AnimatedSprite

func play_anim(animName, dir):
	
	if dir == Player.PLAYER_DIR.LEFT:
		flip_h = true
	else:
		flip_h = false		
	
	if animName == Player.PLAYER_STATE.IDLE:
		if animation != "idle":
			play("idle")
	if animName == Player.PLAYER_STATE.RUN:
		if animation != "run":
			play("run")
	if animName == Player.PLAYER_STATE.WALK:
		if animation != "walk":
			play("walk")
