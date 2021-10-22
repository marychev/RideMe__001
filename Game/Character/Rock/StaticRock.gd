extends StaticBody2D


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func _on_StompDetector_body_entered(body: Node) -> void:
	if "Player" == body.name:
		
		print('_on_StompDetector_body_entered__', body.name)
		print('-------------------------------------------')
		
		body.anim_player.stop()
		body.anim_player.play("collision")
		PlayerData.lives -= 1
		
		if body.speed.x > body.max_speed / 2:
			PlayerData.lives -= 20
		elif body.speed.x > (body.max_speed * 90 / 100):
			PlayerData.lives -= 50
		
		if PlayerData.lives > 0:
			body.set_speed(-body.speed.x / 2)
		else:
			body.die()
