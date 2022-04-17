extends Node
# GameData
signal score_updated
signal lives_updated
signal rms_updated
signal time_level_updated

onready var player_bike_cfg: PlayerBikeCfg = load(PathData.PLAYER_BIKE_MODEL).new()
onready var lives_value: Label = get_node(PathData.PATH_LIVES_COUNTER_VALUE)
onready var rms_value: Label = get_node(PathData.PATH_RMS_COUNTER_VALUE)
onready var time_level_value: Label = get_node(PathData.PATH_TIME_LEVEL_VALUE)
onready var gui_time: VBoxContainer = get_node(PathData.PATH_GUI_TIME)
onready var player: KinematicBody2D = get_node(PathData.PATH_PLAYER)

var score: = 0 setget set_score # not used anywhere
var time_level_count: int = 0
var time_level: = 0 setget set_time_level
var rms_count: int = 0
var type_title: int = -1

var rms: int = PlayerBikeCfg.DEFAULT_VALUE_RMS setget set_rms
var lives: int = PlayerBikeCfg.DEFAULT_VALUE_LIVES setget set_lives
var player_bike: EmptyBike


func _ready():
	var player_bike_data: = player_bike_cfg.first()
	set_player_data(player_bike_data)
	
	if not player_bike_data.empty() and player_bike_data["bike_title"] != "Empty":
		player_bike = load("res://Game/Bike/" + player_bike_data["bike_title"] + "Bike.gd").new()
		player_bike.set_player_bike(player_bike_data)

	if is_instance_valid(player) and is_instance_valid(GameData.current_track):
		time_level = GameData.current_track.init_time_level


func reset_progress() -> void:
	_ready()
	
	if not is_instance_valid(player):
		player = load(PathData.PATH_PLAYER).new()
		
	rms_count = 0
	time_level_count = 0
	score = 0
	set_lives(lives)


func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")


func set_lives(value: int) -> void:
	if not is_instance_valid(lives_value):
		lives_value = get_node(PathData.PATH_LIVES_COUNTER_VALUE)
		
	lives = value
	lives_value.text = str(lives)
	
	get_node(PathData.PATH_LIVES_COUNTER + "/AnimationPlayer").play('danger')
	emit_signal("lives_updated")


func set_rms(value: int, is_game_mode:= true) -> void:
	var _value = str(rms)
	rms = value

	# when Splash as main sceen
	if not is_instance_valid(rms_value):
		rms_value = get_node(PathData.PATH_RMS_COUNTER_VALUE)
	# when BikeMenu as main sceen
	if not is_instance_valid(rms_value):
		var path = "/root/BikeMenu/TextureRect/RMCounter/Background/Value"
		rms_value = get_node(path)
	# when LevelMenu as main sceen
	if not is_instance_valid(rms_value):
		var path = "/root/LevelMenu/TextureRect/RMCounter/Background/Value"
		rms_value = get_node(path)

	if is_game_mode:
		rms_count += 1
		_value += ' | ' + str(rms_count)
	
	rms_value.set_text(_value)
	emit_signal("rms_updated")


func save_rms(rm: int) -> void:
	player_bike_cfg.set_rm(rm)
	set_rms(rm, false)


func set_time_level(value: int) -> void:
	# when Splash as main sceen
	if not is_instance_valid(time_level_value):
		time_level_value = get_node(PathData.PATH_TIME_LEVEL_VALUE)
		
	# when Game as main sceen
	time_level = value
	time_level_value.set_text(str(time_level) + ' | ' + str(time_level_count))
	emit_signal("time_level_updated")


func set_time_level_count(_player: KinematicBody2D) -> int:
	if not is_instance_valid(player): 
		player = _player

	time_level_count += 1
	
	var finish: Start = GameData.current_track.find_node('Finish')
	var finish_pos_x = player.position.x + 888
	
	if GameData.current_track.are_you_win():	
		if is_instance_valid(finish):
			finish.position.x = finish_pos_x
		else:
			var _finish = load("res://Game/Character/Start/Start.tscn")
			finish = _finish.instance()
			finish.z_index = 1
			finish.set_position(Vector2(finish_pos_x, player.position.y + 100))
			GameData.current_track.add_child(finish)

	return time_level_count


func set_type_title(_type_title: int):
	type_title = _type_title


func set_player_data(player_bike_data: Dictionary) -> void:
	if not player_bike_data.empty():
		rms = player_bike_data["rm"]
		lives = player_bike_data["lives"]
