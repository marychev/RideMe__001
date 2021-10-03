extends HBoxContainer

onready var _label_value: Label = get_node(PlayerData.PATH_SPEED_BAR_COUNT_VALUE) 
onready var _progress: TextureProgress = $"./Gauge"
onready var player: Player = get_node(PlayerData.PATH_PLAYER)


func _ready():
	_progress.max_value = player.max_speed
	

func set_progress_player():
	_label_value.text = '%.2f' % player.speed.x
	_progress.value = player.speed.x
