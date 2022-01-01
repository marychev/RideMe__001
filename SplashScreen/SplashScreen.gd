tool
extends TextureRect

export (String, FILE) var main_menu_tscn: = ""


func _ready():
	$Start.change_scene = main_menu_tscn
	$Start.connect("pressed", self, "on_Start_pressed")
	
	create_levels()
	create_tracks()


func _on_Start_pressed() -> void:
	$Start._on_pressed()


func _get_configuration_warning() -> String:
	var msg: String = "Main Menu scene must be set "
	return msg if main_menu_tscn == "" else ""


func create_levels() -> void:
	var level_cfg: LevelCfg = preload("res://config/LevelCfg.gd").new()
	level_cfg.create(0, "Mountains")
	level_cfg.create(1, "City")


func create_tracks() -> void:
	var _track_id: = -1
	var _level_id: = 0
	var _issue: = "Collect the %s hourgrass!"
	var _resource: = "res://Game/Level/Level_Train/Level_Train.tscn"
	var _texture: = "res://Game/Level/assets/mountains.png"
	var _num_win: = 2
	var _init_time_level: = 100
	var _price: = 0
	
	var track_cfg: TrackCfg = preload("res://config/TrackCfg.gd").new()
	track_cfg.create(_track_id, _level_id, _issue, _resource, _texture, _num_win,  _init_time_level, _price)

	_track_id = 0
	_resource = "res://Game/Level/Level_0/Level_0.tscn"
	_texture = "res://Game/Level/assets/mountains-bottom.png"
	_num_win = 5
	_init_time_level = 20
	_price = 2
	track_cfg.create(_track_id, _level_id, _issue, _resource, _texture, _num_win,  _init_time_level, _price)
	
	_track_id = 1
	_resource = "res://Game/Level/Level_1/Level_1.tscn"
	_num_win = 20
	_init_time_level = 40
	_price = 120
	track_cfg.create(_track_id, _level_id, _issue, _resource, _texture, _num_win,  _init_time_level, _price)
