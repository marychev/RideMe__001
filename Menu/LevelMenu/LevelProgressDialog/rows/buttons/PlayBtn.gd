extends TextureButton

var path_data: PathData = preload("res://Autoload/PathData.gd").new()


func _on_pressed():
	if GameData.current_level:
		get_tree().change_scene(path_data.RES_LEVEL_MENU_TSCN)
	else:
		print("GameData was undefined")
