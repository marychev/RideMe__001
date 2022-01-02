tool
extends MarginContainer
class_name MainMenu

export (String, FILE) var game_tscn: = ""

var path_data: PathData = preload("res://Autoload/PathData.gd").new()
var track_cfg: TrackCfg = preload("res://config/TrackCfg.gd").new()

onready var field_log: FieldLog = preload("res://Game/scripts/FieldLog.gd").new()
onready var btn_bike_menu: TextureIconButton = $HBoxContainer/VBoxContainer/MenuOptions/BikeMenu
onready var btn_level_menu: TextureIconButton = $HBoxContainer/VBoxContainer/MenuOptions/LevelMenu
onready var btn_options: TextureIconButton = $HBoxContainer/VBoxContainer/MenuOptions/Options
onready var btn_play: TextureButton = $HBoxContainer/VBoxContainer/MenuOptions/Play


func _ready() -> void:
	btn_play.modulate.a = 1
	if not can_start_play():
		btn_play.modulate.a = 0.4

	btn_play.hint_tooltip = "Play the %s level track on %s bike" % [
		GameData.current_level.title if GameData.current_level else "no",
		PlayerData.player_bike.title if PlayerData.player_bike else "no",
	]

	if not PlayerData.player_bike:
		btn_bike_menu.anim_flicker()
	
	init_btn_level_menu()
	
	show_player_bike()
	show_current_track()
	

func _on_Play_pressed():
	if not PlayerData.player_bike and not GameData.current_level:
		field_log.target = $HBoxContainer/VBoxContainer/Logo
		field_log.position = Vector2(10, 66)
		field_log_start_play()
	else:
		get_tree().change_scene(game_tscn)


func can_start_play() -> bool:
	var has_tracks: bool = not str(track_cfg.get_id(track_cfg.get_section(0))).empty()
	return PlayerData.player_bike and GameData.current_level and has_tracks


func field_log_start_play() -> void:
	if not PlayerData.player_bike:
		field_log.error("No bike selected! You don't have a bike")
	elif not GameData.current_level:
		field_log.error("No level selected! You don't have the current level")
	else:
		var error = "Undefined error. You can not start play. Try ro reboot game"
		field_log.error(error)


func init_btn_level_menu():
	if track_cfg.get_id(track_cfg.get_section(0)) != 0:
		btn_level_menu.modulate.a = 0.4
		btn_level_menu.disabled = true
	else:
		btn_level_menu.modulate.a = 1
		btn_level_menu.disabled = false

		if not GameData.current_level:
			btn_level_menu.anim_flicker()


func show_player_bike() -> void:
	if PlayerData.player_bike:
		var _sataur: TextureRect = $HBoxContainer/CenterContainer/Characters/Sataur
		var _drawster: TextureRect = $HBoxContainer/CenterContainer/Characters/Drawster

		if _sataur.name == PlayerData.player_bike.title:
			_sataur.modulate.a = 1
			_drawster.visible = false
		elif _drawster.name == PlayerData.player_bike.title:
			_drawster.modulate.a = 1
			_sataur.visible = false


func show_current_track() -> void:
	var level_track: = GameData.current_track if GameData.current_track else GameData.current_level
	if level_track:
		var _current_track: NinePatchRect = $HBoxContainer/CenterContainer/CurrentTrack
		_current_track.visible = true
		_current_track.texture = level_track.texture


func _get_configuration_warning() -> String:
	var msg:String = "Game scene must be set "
	return msg if game_tscn == "" else ""
