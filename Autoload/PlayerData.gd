extends Node

signal score_updated
signal lives_updated
signal rms_updated
signal time_level_updated

const INIT_LIVES: = 100

var score: = 0 setget set_score
var lives: = INIT_LIVES setget set_lives
var time_level_count: int = 0
var time_level: = 0 setget set_time_level
var rms: = 100 setget set_rms

var type_title: int = -1

var player_bike: Node
var path_data: PathData = preload("res://Autoload/PathData.gd").new()

onready var lives_value: Label = get_node(path_data.PATH_LIVES_COUNTER_VALUE)
onready var rms_value: Label = get_node(path_data.PATH_RMS_COUNTER_VALUE)
onready var time_level_value: Label = get_node(path_data.PATH_TIME_LEVEL_VALUE)
onready var gui_time: VBoxContainer = get_node(path_data.PATH_GUI_TIME)
onready var player: KinematicBody2D = get_node(path_data.PATH_PLAYER)


func _ready():
	if is_instance_valid(player) and player.current_level.INIT_TIME_LEVEL:
		time_level = player.current_level.INIT_TIME_LEVEL


func reset_progress() -> void:
	_ready()

	if not is_instance_valid(player):
		player = load(path_data.PATH_PLAYER).new()
		
	time_level_count = 0
	score = 0
	lives = INIT_LIVES


func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")


func set_lives(value: int) -> void:
	if not is_instance_valid(lives_value):
		lives_value = get_node(path_data.PATH_LIVES_COUNTER_VALUE)
		
	lives = value
	lives_value.text = str(lives)
	
	get_node(path_data.PATH_LIVES_COUNTER + "/AnimationPlayer").play('danger')
	
	emit_signal("lives_updated")


func set_rms(value: int) -> void:
	# when Splash as main sceen
	if not is_instance_valid(rms_value):
		rms_value = get_node(path_data.PATH_RMS_COUNTER_VALUE)

	# when BikeMenu as main sceen
	if not is_instance_valid(rms_value):
		var path = "/root/BikeMenu/TextureRect/RMCounter/Background/Value"
		rms_value = get_node(path)
		
	rms = value
	rms_value.set_text(str(rms))
	emit_signal("rms_updated")


func set_time_level(value: int) -> void:
	# when Splash as main sceen
	if not is_instance_valid(time_level_value):
		time_level_value = get_node(path_data.PATH_TIME_LEVEL_VALUE)
		
	# when Game as main sceen
	time_level = value
	time_level_value.text = str(time_level) + ' | ' + str(time_level_count)
	emit_signal("time_level_updated")


func set_time_level_count(_player: KinematicBody2D) -> int:
	if not is_instance_valid(player): 
		player = _player

	time_level_count += 1
	
	if player.current_level.are_you_win():
		var _finish = load("res://Game/Character/Start/Start.tscn")
		var finish = _finish.instance()
		
		var game = get_node(path_data.PATH_GAME)
		var road = game.FirstRoadBody
		var road_texture = road.get_node('sprite').texture.get_size()
		
		finish.set_position(
			Vector2(
				player.position.x + 888,
				(road.position.y * 2) + (road_texture.y / 2)
			)
		)
		
		game.add_child(finish)

	return time_level_count


func set_type_title(_type_title: int):
	type_title = _type_title

