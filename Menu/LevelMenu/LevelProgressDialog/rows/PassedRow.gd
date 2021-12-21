extends ActiveRow
class_name PassedRow


func _on_ReplayBtn_pressed():
	GameData.current_level = current_level
	
	if GameData.current_level:
		get_tree().change_scene(path_data.RES_LEVEL_MENU_TSCN)
	else:
		print("GameData was undefined")
