extends Control


onready var label:Label = get_node("PauseRect/Label")


func _ready() -> void:
	label.text = label.text % [PlayerData.score]
