extends RigidBody2D

onready var live: int = 2


func _on_StompDetector_body_entered(body: Node) -> void:
	if "Player" == body.name:
		$sprite.flip_v = true
		
		live -= 1
		body.anim_player.stop()
		
		if live == 0:
			die()


func _on_VisibilityEnabler2D_screen_exited() -> void:
	queue_free()


func die():
	live = 0
	$Collision.disabled = true
	queue_free()



