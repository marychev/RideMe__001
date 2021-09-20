extends RigidBody2D

onready var live: int = 2


func _ready():
	set_physics_process(false)


func _on_StompDetector_body_entered(body: Node) -> void:
	print('[_on_StompDetector_body_entered]: ', body.name, live)
	if "Player" == body.name:
		live -= 1
		# if body.global_position.y > $StompDetector.global_position.y:
		$sprite.flip_v = true
		if live == 0:
			die()
		

func die():
	print('[BOOM]: Add a new sprites the broken planks, two another', self)
	live == 0
	$Collision.disabled = true
	queue_free()
	


func _on_VisibilityEnabler2D_screen_exited() -> void:
	queue_free()
