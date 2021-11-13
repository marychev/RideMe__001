class_name AnimatePeople


func do_collision(animation:AnimationPlayer, player: Player):
	animation.play("collision")
		
	if PlayerData.lives > 25:
		PlayerData.lives /= 2
	else:
		PlayerData.lives = 0

	player.set_speed(-player.max_speed)
	player.anim_player.play('collision')
