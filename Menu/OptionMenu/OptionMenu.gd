extends MarginContainer
class_name OptionMenu

var bike_cfg: BikeCfg = load(PathData.BIKE_MODEL).new()
var player_bike_cfg: PlayerBikeCfg = load(PathData.PLAYER_BIKE_MODEL).new()


func _on_ResetGame_pressed():
	reset_game_config()
	
	var audio_btn_run = load("res://media/ui/btn_run.wav")
	$VBoxContainer/Return/AudioStreamPlayer2D.set_stream(audio_btn_run)
	$VBoxContainer/Return/AudioStreamPlayer2D.play()
	yield(get_tree().create_timer(1), "timeout")
	
	get_tree().change_scene(PathData.RES_MAIN_MENU_TSCN)


func reset_game_config():
	clear_game_config()
	
	create_bikes()
	create_player_bike()
	create_levels()
	create_tracks()
	create_player_track()
	
	PlayerData._ready()
	GameData._ready()


func clear_game_config():
	bike_cfg.clear()
	player_bike_cfg.clear()
	GameData.track_cfg.clear()
	GameData.player_track_cfg.clear()
	
	GameData.current_level = {}
	GameData.current_track = null
	PlayerData.player_bike = null


func create_player_bike() -> void:
	player_bike_cfg.create("Empty")


func create_bikes() -> void:
	EmptyBike.create_for_cfg()
	SataurBike.create_for_cfg()
	DrawsterBike.create_for_cfg()
	

func create_levels() -> void:
	GameData.level_cfg.create(1, "Mountains")
	GameData.level_cfg.create(2, "City")


func create_tracks() -> void:
	var _level_id: = 1
	var _track_id: = 0
	var _issue: = "Collect the %s hourgrass."
	var _resource: = "res://Game/Level/Level_0/Level_0.tscn"
	var _texture: = "res://Game/Level/assets/slides/track-00.png"
	var _num_win: = 2
	var _init_time_level: = 100
	var _price: = 0
	var _state: = LevelTrackStates.ACTIVE
	
	# GameData.track_cfg.create(_track_id, _level_id, _issue, _resource, _texture, _num_win,  _init_time_level, _price, _state)
	
	
	Level_0.create_for_cfg()
	Level_1.create_for_cfg()
	Level_2.create_for_cfg()
	Level_3.create_for_cfg()
	
	Level2_0.create_for_cfg()
	
	"""
	_track_id = 1
	_resource = "res://Game/Level/Level_1/Level_1.tscn"
	_texture = "res://Game/Level/assets/slides/track-01.png"
	_num_win = 5
	_init_time_level = 20
	_price = 2
	GameData.track_cfg.create(_track_id, _level_id, _issue, _resource, _texture, _num_win,  _init_time_level, _price)
	
	_track_id = 2
	_resource = "res://Game/Level/Level_2/Level_2.tscn"
	_texture = "res://Game/Level/assets/slides/track-02.png"
	_num_win = 10
	_init_time_level = 30
	_price = 10
	GameData.track_cfg.create(_track_id, _level_id, _issue, _resource, _texture, _num_win,  _init_time_level, _price)

	_track_id = 3
	_resource = "res://Game/Level/Level_3/Level_3.tscn"
	# _texture = "res://Game/Level/assets/mountains.png"
	_texture = "res://Game/Level/assets/slides/track-03.png"
	_num_win = 11
	_init_time_level = 18
	_price = 20
	_issue = "Time is limited. " + _issue
	GameData.track_cfg.create(_track_id, _level_id, _issue, _resource, _texture, _num_win,  _init_time_level, _price)
	
	# Level 2
	_level_id = 2
	_track_id = 4
	_resource = "res://Game/Level2/Level2_0/Level2_0.tscn"
	_texture = "res://Game/Level/assets/mountains.png"
	_num_win = 88
	_init_time_level = 888
	_price = 8
	_issue = "Time is limited. " + _issue
	GameData.track_cfg.create(_track_id, _level_id, _issue, _resource, _texture, _num_win,  _init_time_level, _price, _state)
	"""

func create_player_track() -> void:
	var track_train_id := 0
	var track_section: String = GameData.track_cfg.get_section(track_train_id)
	var track_resource = GameData.track_cfg.get_resource(track_section)
	
	var player_track_section := track_section.replace(GameData.track_cfg.prefix, GameData.player_track_cfg.prefix)
	GameData.player_track_cfg.create(track_section, player_track_section)
	GameData.track_cfg.set_state(track_section, LevelTrackStates.ACTIVE)

	GameData.current_track = load(track_resource).instance()
	GameData.current_track.resource = track_resource
