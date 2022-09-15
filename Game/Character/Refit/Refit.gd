extends Area2D
class_name Refit


func _on_body_entered(body: Player) -> void:
	# Happened error on Level2_1: Invalid get index 'name' (on base: 'Nil') 
	if is_instance_valid(body) and body.name == "Player":
		modulate = Color.green
		
		body.anim_player.play(PlayerData.ANIMATION_SUCCESS)
		body.get_node('AudioMove').set_stream(body.audio_colected)
		body.get_node('AudioMove').play()
		
		PlayerData.lives += 50
		


func _ready() -> void:
	set_physics_process(false)



func _on_Refit_body_exited(body):
	queue_free()
