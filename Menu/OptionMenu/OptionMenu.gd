extends MarginContainer
class_name OptionMenu

var path_data: PathData = preload("res://Autoload/PathData.gd").new()
var level_cfg: LevelCfg = preload("res://config/LevelCfg.gd").new()
var track_cfg: TrackCfg = preload("res://config/TrackCfg.gd").new()
var player_track_cfg: PlayerTrackCfg = preload("res://config/PlayerTrackCfg.gd").new()


func _on_ClearGame_pressed():
	track_cfg.clear()
	player_track_cfg.clear()
	

func _on_ResetGame_pressed():
	create_levels()
	create_tracks()


# Managing to app user data

func create_levels() -> void:
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


func reset_player_tracks() -> void:
	player_track_cfg.config.clear()
