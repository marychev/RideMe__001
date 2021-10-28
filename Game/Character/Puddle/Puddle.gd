extends Area2D


func _physics_process(delta):
	set_physics_process(false)


func _on_body_entered(body):
	if body.name == "Player":
		body.set_speed(body.speed.x / 2)
		body.set_power(body.power / 2)
		get_tree().queue_delete(self)



func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()
