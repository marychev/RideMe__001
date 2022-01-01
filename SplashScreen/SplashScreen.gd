tool
extends TextureRect

export (String, FILE) var main_menu_tscn: = ""


func _get_configuration_warning() -> String:
	var msg: String = "Main Menu scene must be set "
	return msg if main_menu_tscn == "" else ""
