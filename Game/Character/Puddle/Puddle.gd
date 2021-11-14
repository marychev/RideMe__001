extends Area2D

var player: Player

func _physics_process(delta):
	set_physics_process(false)


func _on_body_entered(body):
	if body.name == "Player":
		player = body
		$Particles.emitting = true
		PlayerData.lives -= 1
		player.set_speed(player.speed.x / 2)
		player.set_power(player.power / 2)
		player.anim_player.play('collision')


func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()
