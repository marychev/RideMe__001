extends HBoxContainer

var PlayerScn

onready var _label_value = $"./Count/Background/Value"
onready var _progress = $"./Gauge"


func force_init(player_scene):
	PlayerScn = player_scene
	_progress.max_value = PlayerScn.max_power


func set_progress_player():
	_label_value.text = '%.2f' % PlayerScn.power
	_progress.value = PlayerScn.power
