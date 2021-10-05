extends Control

onready var label:Label = get_node("PauseRect/Label")
onready var title:Label = get_node("PauseRect/Title")


func _ready() -> void:
	if PlayerData.lives == 0:
		title.set_text("You fail.")
		
	label.text = label.text % [
		PlayerData.rms,
		PlayerData.score,
		timer_format(PlayerData.time_level)
	]


func timer_format(time):
	return "%02d : %02d : %02d" % [
		fmod(time, 60 * 60) / 60,
		fmod(time, 60),
		fmod(time, 1) * 100
	]
