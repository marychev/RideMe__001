extends TextureIconButton
class_name NextLevelBtn


func _pressed():
	._on_pressed()
	get_tree().paused = false
	print('NEXT:', GameData.current_track, PlayerData.rms, PlayerData.rms_count)
	
	# Curret level
	# Curret track + 1 if < max_track
