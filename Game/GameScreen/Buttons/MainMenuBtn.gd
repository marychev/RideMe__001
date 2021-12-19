extends Node

var path_data: PathData = load("res://Autoload/PathData.gd").new()


func _on_button_up() -> void:
	var main_menu: String = path_data.RES_MAIN_MENU_TSCN
	get_tree().change_scene(main_menu)
