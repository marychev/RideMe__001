extends Area2D


func _on_Puddle_body_entered(body):
	if body.name == "Player":
		body.set_speed(body.speed.x / 2)
		body.set_power(body.power / 2)
		get_tree().queue_delete(self)
