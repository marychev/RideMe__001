extends KinematicBody2D
onready var player: Player = get_node("/root/Game/Player")


func _physics_process(delta):
	if player:
		#position.x = player.position.x
		#position.y = position.y + 1

		var direction = (player.global_position - global_position).normalized()
		move_and_collide(direction * 1)


func _on_MotionDetecter_body_entered(body: Player):
	if body != self:
		# player = body
		print("Gav gav ...")
		


func _on_MotionDetecter_body_exited(body: Player):
	#player = null
	print("Buy buy dog!")
	#queue_free()
