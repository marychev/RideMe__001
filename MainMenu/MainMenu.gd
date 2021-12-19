tool
extends MarginContainer

export (String, FILE) var game_tscn: = ""

var path_data: PathData = preload("res://Autoload/PathData.gd").new()

onready var field_log: FieldLog = preload("res://Game/scripts/FieldLog.gd").new()
onready var btn_play: TextureButton = $HBoxContainer/VBoxContainer/MenuOptions/Play


func _ready() -> void:
	if not PlayerData.player_bike:
		btn_play.modulate.a = 0.4


func _on_Play_pressed():
	if not PlayerData.player_bike:
		field_log.target = $HBoxContainer/VBoxContainer/Logo
		field_log.position = Vector2(10, 66)
		field_log.error("No bike selected! You don't have a bike")
	else:
		get_tree().change_scene(game_tscn)


func _on_BikeMenu_pressed() -> void:
	get_tree().change_scene(path_data.BIKE_MENU_SCREEN)


func _on_LevelMenu_pressed() -> void:
	get_tree().change_scene(path_data.RES_LEVEL_MENU_TSCN)
	

func _on_Options_pressed() -> void:
	field_log.target = $HBoxContainer/VBoxContainer/Logo
	field_log.info("TO DO")


func _get_configuration_warning() -> String:
	var msg:String = "Game scene must be set "
	return msg if game_tscn == "" else ""
