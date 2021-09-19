extends Area2D
class_name Grass


func _on_Grass_body_entered(body):
	if body.name == "Player":
		body.set_speed(body.speed.x/2)
		body.set_power(body.power/2)
		
		var animation: AnimationPlayer = body.get_node("AnimationPlayer")
		if animation.current_animation:
			animation.stop()
