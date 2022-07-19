extends Area2D
class_name Refit


func _on_body_entered(body: Player) -> void:
	# Happened error on Level2_1: Invalid get index 'name' (on base: 'Nil') 
	if is_instance_valid(body) and body.name == "Player":
		body.get_node('AudioMove').set_stream(body.audio_colected)
		body.get_node('AudioMove').play()
		PlayerData.lives += 50
		queue_free()


func _ready() -> void:
	set_physics_process(false)


