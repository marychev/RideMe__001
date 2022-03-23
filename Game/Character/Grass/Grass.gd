extends BaseArea2D
class_name Grass


func _on_body_entered(body):
	if body.name == "Player":
		._on_body_entered(body)
		
		var animation: AnimationPlayer = body.get_node("AnimationPlayer")
		if animation.current_animation:
			animation.stop()


func _on_VisibilityEnabler_screen_exited() -> void:
	queue_free()
