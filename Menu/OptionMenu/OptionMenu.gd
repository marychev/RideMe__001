extends MarginContainer
class_name OptionMenu

var bike_cfg: BikeCfg = load(PathData.BIKE_MODEL).new()
var player_bike_cfg: PlayerBikeCfg = load(PathData.PLAYER_BIKE_MODEL).new()
var level_cfg: LevelCfg = load(PathData.LEVEL_MODEL).new()
var track_cfg: TrackCfg = load(PathData.TRACK_MODEL).new()
var player_track_cfg: PlayerTrackCfg = load(PathData.PLAYER_TRACK_MODEL).new()


func _on_ResetGame_pressed():
	clear_game_config()
	
	create_bikes()
	create_player_bike()
	create_levels()
	create_tracks()
	create_player_track()
	
	var audio_btn_run = load("res://media/ui/btn_run.wav")
	$VBoxContainer/Return/AudioStreamPlayer2D.set_stream(audio_btn_run)
	$VBoxContainer/Return/AudioStreamPlayer2D.play()
	yield(get_tree().create_timer(1), "timeout")
	
	GameData._ready()
	get_tree().change_scene(PathData.RES_MAIN_MENU_TSCN)


func clear_game_config():
	bike_cfg.clear()
	track_cfg.clear()
	player_bike_cfg.clear()
	player_track_cfg.clear()
	
	GameData.current_level = {}
	GameData.current_track = null
	PlayerData.player_bike = null


func create_player_bike() -> void:
	player_bike_cfg.create("Empty")


func create_bikes() -> void:
	var _title: = "Empty"
	var _texture: ="res://Game/Bike/assets/I/animation/collision.png"
	var _max_speed = 0.00
	var _max_height_jump = 0.00
	var _power = 0.00
	var _max_power = 0.00
	var _price: = 0
	bike_cfg.create(_title, _texture, _max_speed, _max_height_jump, _power, _max_power, _price)
	
	_title = "Sataur"
	_texture = "res://Game/Bike/assets/I/sprites.png"
	_max_speed = 520.00
	_max_height_jump = 860.00
	_power = 300.00
	_max_power = 400.00
	_price = 90
	bike_cfg.create(_title, _texture, _max_speed, _max_height_jump, _power, _max_power, _price)
	
	_title = "Drawster"
	_texture = "res://Game/Bike/assets/II/sprites.png"
	_max_speed = 500.00
	_max_height_jump = 870.00
	_power = 300.00
	_max_power = 420.00
	_price = 80
	bike_cfg.create(_title, _texture, _max_speed, _max_height_jump, _power, _max_power, _price)
	

func create_levels() -> void:
	level_cfg.create(1, "Mountains")
	level_cfg.create(2, "City")


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
	track_cfg.create(_track_id, _level_id, _issue, _resource, _texture, _num_win,  _init_time_level, _price, _state)
	
	_track_id = 1
	_resource = "res://Game/Level/Level_1/Level_1.tscn"
	_texture = "res://Game/Level/assets/slides/track-01.png"
	_num_win = 5
	_init_time_level = 20
	_price = 2
	track_cfg.create(_track_id, _level_id, _issue, _resource, _texture, _num_win,  _init_time_level, _price)
	
	_track_id = 2
	_resource = "res://Game/Level/Level_2/Level_2.tscn"
	_texture = "res://Game/Level/assets/slides/track-02.png"
	_num_win = 10
	_init_time_level = 30
	_price = 10
	track_cfg.create(_track_id, _level_id, _issue, _resource, _texture, _num_win,  _init_time_level, _price)

	_track_id = 3
	_resource = "res://Game/Level/Level_3/Level_3.tscn"
	# _texture = "res://Game/Level/assets/mountains.png"
	_texture = "res://Game/Level/assets/slides/track-03.png"
	_num_win = 11
	_init_time_level = 18
	_price = 20
	_issue = "Time is limited. " + _issue
	track_cfg.create(_track_id, _level_id, _issue, _resource, _texture, _num_win,  _init_time_level, _price)


func create_player_track() -> void:
	var track_train_id := 0
	var track_section := track_cfg.get_section(track_train_id)
	var track_resource = track_cfg.get_resource(track_section)
	
	var player_track_section := track_section.replace(track_cfg.prefix, player_track_cfg.prefix)
	player_track_cfg.create(track_section, player_track_section)
	track_cfg.set_state(track_section, LevelTrackStates.ACTIVE)
		
	GameData.current_track = load(track_resource).instance()
	GameData.current_track.resource = track_resource

