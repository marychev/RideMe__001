extends BaseArea2D
class_name Puddle


func _on_body_entered(body):
	if body.name == "Player":
		._on_body_entered(body)
		body.anim_player.play(PlayerData.ANIMATION_COLLISION)
		
		$Particles.emitting = true
		PlayerData.lives -= 1


func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()
