extends StaticBody2D


func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()


func _on_StompDetector_body_entered(body: Node) -> void:
	if "Player" == body.name:
		PlayerData.lives -= 1
