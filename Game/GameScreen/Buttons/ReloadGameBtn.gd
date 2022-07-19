extends TextureIconButton
class_name ReloadGameBtn


func _on_pressed():
	._on_pressed()
	
	# PlayerData.score = 0
	GameData.reload_game(GameData.current_track.ID)
	# GameData._ready()
	
	get_tree().paused = false
	get_tree().reload_current_scene()
