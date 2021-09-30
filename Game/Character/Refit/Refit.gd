extends Area2D


func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		PlayerData.lives += 50
		queue_free()


func _ready() -> void:
	set_physics_process(false)


