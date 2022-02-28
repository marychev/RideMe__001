extends TextureIconButton
class_name ReloadGameBtn


func _pressed():
	._on_pressed()
	PlayerData.score = 0
	PlayerData.set_lives(PlayerData.player_bike_cfg.get_lives())
	get_tree().paused = false
	get_tree().reload_current_scene()
