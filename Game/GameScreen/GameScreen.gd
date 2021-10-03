extends Control

onready var sceen_tree: = get_tree()
onready var pause_rect: ColorRect = get_node("PauseRect")


var paused: = false setget set_paused
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = not paused
		sceen_tree.set_input_as_handled()


func set_paused(value: bool) -> void:
	paused = value
	sceen_tree.paused = value
	pause_rect.visible = value

