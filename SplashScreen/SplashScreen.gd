tool
extends TextureRect

export (String, FILE) var main_menu_tscn: = ""


func _on_Start_pressed() -> void:
	get_tree().change_scene(main_menu_tscn)


func _get_configuration_warning() -> String:
	var msg:String = "Main Menu scene must be set "
	return msg if main_menu_tscn == "" else ""
