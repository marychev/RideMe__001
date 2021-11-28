tool
extends MarginContainer

export (String, FILE) var game_tscn: = ""


func _ready() -> void:
	if not PlayerData.player_bike:
		$HBoxContainer/VBoxContainer/MenuOptions/Contunue.modulate.a = 0.4


func _on_NewGame_pressed() -> void:
	get_tree().change_scene(PlayerData.BIKE_MENU_SCREEN)


func _on_Contunue_pressed():
	if not PlayerData.player_bike:
		var msg = Label.new()
		msg.set_text("No bike selected! You don't have a bike.")
		msg.set_position(Vector2(10, 66))
		msg.set_scale(Vector2(2, 2))
		$HBoxContainer/VBoxContainer/Logo.add_child(msg)
	else:
		get_tree().change_scene(game_tscn)


func _get_configuration_warning() -> String:
	var msg:String = "Game scene must be set "
	return msg if game_tscn == "" else ""



func _on_Contunue_button_down() -> void:
	# modulate.a = 1
	pass


func _on_Contunue_button_up() -> void:
	# modulate.a = 0.2
	pass
