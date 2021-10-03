extends Node

signal score_updated
signal lives_updated
signal rms_updated

const INIT_LIVES: = 100

var score: = 0 setget set_score
var lives: = INIT_LIVES setget set_lives
var rms: = 0 setget set_rms

const PATH_PLAYER = "/root/Game/Player"

const PATH_GUI = "/root/Game/GUI/Canvas"
const PATH_GAME_SCREEN_PAUSE = PATH_GUI + "/GameScreenPause"
const PATH_LIVES_COUNTER_VALUE = PATH_GUI + "/Counters/LivesCounter/Background/Value"
const PATH_RMS_COUNTER_VALUE = PATH_GUI + "/Counters/RMCounter/Background/Value"
const PATH_SPEED_BAR = PATH_GUI + "/HBoxContainer/Bars/SpeedBar"
const PATH_POWER_BAR = PATH_GUI + "/HBoxContainer/Bars/PowerBar"
const PATH_SPEED_BAR_COUNT_VALUE = PATH_SPEED_BAR + "/Count/Background/Value"
const PATH_POWER_BAR_COUNT_VALUE = PATH_SPEED_BAR + "/Count/Background/Value"
const PATH_JUMP_BTN = PATH_GUI + "/ControlContainer/JumpBtn"
const PATH_GO_BTN = PATH_GUI + "/ControlContainer/GoBtn"
const PATH_STOP_BTN = PATH_GUI + "/ControlContainer/StopBtn"

onready var lives_value: Label = get_node(PATH_LIVES_COUNTER_VALUE)
onready var rms_value: Label = get_node(PATH_RMS_COUNTER_VALUE)


func reset_progress() -> void:
	score = 0
	lives = INIT_LIVES


func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")


func set_lives(value: int) -> void:
	lives = value
	lives_value.text = str(lives)
	emit_signal("lives_updated")


func set_rms(value: int) -> void:
	rms = value
	rms_value.text = str(rms)
	emit_signal("rms_updated")


