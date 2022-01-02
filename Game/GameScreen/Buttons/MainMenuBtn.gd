extends Node
class_name MainMenuBtn


func _on_button_up() -> void:
	var main_menu_res: String = PathData.RES_MAIN_MENU_TSCN
	get_tree().paused = false
	get_tree().change_scene(main_menu_res)
