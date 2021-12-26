tool
extends MarginContainer
class_name MainMenu

export (String, FILE) var game_tscn: = ""

var path_data: PathData = preload("res://Autoload/PathData.gd").new()

onready var field_log: FieldLog = preload("res://Game/scripts/FieldLog.gd").new()
onready var btn_play: TextureButton = $HBoxContainer/VBoxContainer/MenuOptions/Play


func _ready() -> void:
	btn_play.modulate.a = 1
	
	btn_play.hint_tooltip = "Play the %s level track on %s bike" % [
		GameData.current_level.title if GameData.current_level else "no",
		PlayerData.player_bike.title if PlayerData.player_bike else "no",
	]
	
	if not can_start_play():
		btn_play.modulate.a = 0.4
		

func _on_Play_pressed():
	if not PlayerData.player_bike and not GameData.current_level:
		field_log.target = $HBoxContainer/VBoxContainer/Logo
		field_log.position = Vector2(10, 66)
		field_log_start_play()
	else:
		get_tree().change_scene(game_tscn)


func _on_BikeMenu_pressed() -> void:
	get_tree().change_scene(path_data.BIKE_MENU_SCREEN)


func _on_LevelMenu_pressed() -> void:
	get_tree().change_scene(path_data.RES_LEVEL_MENU_TSCN)
	

func _on_Options_pressed() -> void:
	field_log.target = $HBoxContainer/VBoxContainer/Logo
	field_log.info("TO DO")


func can_start_play() -> bool:
	return PlayerData.player_bike and GameData.current_level
	

func field_log_start_play() -> void:
	if not PlayerData.player_bike:
		field_log.error("No bike selected! You don't have a bike")
	elif not GameData.current_level:
		field_log.error("No level selected! You don't have the current level")
	else:
		var error = "Undefined error. You can not start play. Try ro reboot game"
		field_log.error(error)


func _get_configuration_warning() -> String:
	var msg:String = "Game scene must be set "
	return msg if game_tscn == "" else ""
