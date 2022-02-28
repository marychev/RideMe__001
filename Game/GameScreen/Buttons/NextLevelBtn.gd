extends TextureIconButton
class_name NextLevelBtn


func _pressed():
	._on_pressed()
	get_tree().paused = false
	print('NEXT: set tracks: ', GameData.current_level)
	print(GameData.current_track)
	
	# Curret level
	# Curret track + 1 if < max_track
