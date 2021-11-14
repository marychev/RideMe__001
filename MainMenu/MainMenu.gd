tool
extends MarginContainer

export (String, FILE) var game_tscn: = ""


func _on_NewGame_pressed() -> void:
	get_tree().change_scene(PlayerData.BIKE_MENU_SCREEN)


func _on_Contunue_pressed():
	get_tree().change_scene(game_tscn)


func _get_configuration_warning() -> String:
	var msg:String = "Game scene must be set "
	return msg if game_tscn == "" else ""
