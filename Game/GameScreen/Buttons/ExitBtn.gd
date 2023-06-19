extends TextureIconButton
class_name ExitBtn


func _pressed():
	if OS.get_name() == 'HTML5':
		get_tree().paused = false
		# Note: reload page via js `location.reload()` 
		GameData._ready()
		PlayerData._ready()
		._on_pressed()
	else:
		get_tree().quit()
