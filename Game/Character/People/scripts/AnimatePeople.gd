class_name AnimatePeople

const COLLISION_SPEED_X := 200


func do_collision(animation:AnimationPlayer, player: Player):
	if animation:
		animation.play("collision")

	hitting_player(player)


func hitting_player(player: Player):
	if PlayerData.lives > 25:
		PlayerData.lives /= 2
	else:
		PlayerData.lives = 0

	player._velocity.x -= (player.speed.x * 2) + COLLISION_SPEED_X
	player.set_speed(player._velocity.x)
	player.anim_player.play('collision')
