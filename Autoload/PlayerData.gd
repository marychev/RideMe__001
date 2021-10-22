extends "res://Autoload/BasePlayerData.gd"

signal score_updated
signal lives_updated
signal rms_updated
signal time_level_updated

const INIT_LIVES: = 100
const INIT_TIME_LEVEL: = 10

var score: = 0 setget set_score
var lives: = INIT_LIVES setget set_lives
var time_level_count: int = 0
var time_level: = INIT_TIME_LEVEL setget set_time_level
var rms: = 0 setget set_rms

onready var lives_value: Label = get_node(PATH_LIVES_COUNTER_VALUE)
onready var rms_value: Label = get_node(PATH_RMS_COUNTER_VALUE)
onready var time_level_value: Label = get_node(PATH_TIME_LEVEL_VALUE)

onready var gui_time: VBoxContainer = get_node(PATH_GUI_TIME)


func reset_progress() -> void:
	score = 0
	lives = INIT_LIVES
	time_level = INIT_TIME_LEVEL


func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")


func set_lives(value: int) -> void:
	if not lives_value:
		lives_value = get_node(PATH_LIVES_COUNTER_VALUE)
		
	lives = value
	lives_value.text = str(lives)
	
	get_node(PATH_LIVES_COUNTER + "/AnimationPlayer").play('danger')
	
	emit_signal("lives_updated")


func set_rms(value: int) -> void:
	# when Splash as main sceen
	if not rms_value:
		rms_value = get_node(PATH_RMS_COUNTER_VALUE)

	rms = value
	rms_value.text = str(rms)
	emit_signal("rms_updated")


func set_time_level(value: int) -> void:
	# when Splash as main sceen
	if not time_level_value:
		time_level_value = get_node(PATH_TIME_LEVEL_VALUE)
		
	# when Game as main sceen
	time_level = value
	time_level_value.text = str(time_level) + ' | ' + str(time_level_count)
	
	emit_signal("time_level_updated")


func set_time_level_count(player: KinematicBody2D) -> int:
	time_level_count += 1
	
	if player.current_level.are_you_win():
		var _finish = load("res://Game/Character/Start/Start.tscn")
		var finish = _finish.instance()
		finish.set_position(
			Vector2(
				player.position.x + 800, 
				player.position.y + 300)
		)
	
		var game = get_node(PlayerData.PATH_GAME)
		game.add_child(finish)

	return time_level_count

