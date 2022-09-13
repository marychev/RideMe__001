class_name AnimatePeople

const COLLISION_SPEED_X:int = 200


func do_collision(
	animation:AnimationPlayer, player: Player, 
	target: Node = null
) -> void:
	if animation:
		animation.play("collision")

	hitting_player(player)
	do_bound(player, target)



func hitting_player(player: Player) -> void:
	player._velocity.x -= player.speed.x + COLLISION_SPEED_X
	player.set_speed(player._velocity.x)
	player.anim_player.play('collision')
	
	if PlayerData.lives > 25:
		PlayerData.lives /= 2
	else:
		PlayerData.lives = 0
		player.anim_player.get_animation('collision').set_loop(true)
		die_from_person(player)


func do_bound(player: Player, target: Node) -> void:
	var has_passed:bool = target.global_position > player.global_position
	target.position.x += COLLISION_SPEED_X if has_passed else -COLLISION_SPEED_X
	player.position.x += -COLLISION_SPEED_X if has_passed else COLLISION_SPEED_X


func die_from_person(player: Player) -> void:
	var die = load(PathData.PATH_DIE_PLAYER).new()
	die.from_hir_person(player)
