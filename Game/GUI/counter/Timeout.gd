extends MarginContainer
class_name Timeout

onready var timer: Timer = get_node("Timer")
onready var timer_value: Label = get_node("Background/Value")
onready var player: Player = get_node(PlayerData.PATH_PLAYER)


func _ready() -> void:
	timer.start()
	timer_value.set_text(str(PlayerData.time_level))


func _on_Timer_timeout() -> void:
	if PlayerData.time_level == 0:
		player.die(true)
	
	PlayerData.time_level -= 1
