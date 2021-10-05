extends RigidBody2D

var animation: AnimationPlayer


func _on_tree_entered() -> void:
	if not animation:
		animation = $AnimationPlayer
	
	animation.play("walk")


func _on_StopmDetector_body_entered(body: Node) -> void:
	if "Player" == body.name:
		animation.play("collision")	
		PlayerData.lives /= 2
		body.set_speed(-body.max_speed / 2)
