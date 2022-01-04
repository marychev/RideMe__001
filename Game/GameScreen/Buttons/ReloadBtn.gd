extends Button


func _on_button_up() -> void:
	PlayerData.score = 0
	PlayerData.set_lives(PlayerData.INIT_LIVES)
	get_tree().paused = false
	get_tree().reload_current_scene()
