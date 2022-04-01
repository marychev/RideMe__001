extends Area2D


func _on_body_entered(body: Player) -> void:
	if body.name == "Player":
		body.get_node('AudioMove').set_stream(body.audio_colected)
		body.get_node('AudioMove').play()
		PlayerData.lives += 50
		queue_free()


func _ready() -> void:
	set_physics_process(false)


