extends Control

onready var sceen_tree: = get_tree()
onready var pause_rect: ColorRect = get_node("PauseRect")
onready var title: Label = get_node("PauseRect/Title")
onready var container_btn: VBoxContainer = get_node("PauseRect/Container")

var _counter: int = 1
var paused: = true setget set_paused


func _ready():
	set_paused(true)
	pause_rect.visible = true
	title.visible = false
	container_btn.visible = false

	$Timer.start()
	$TimeToStart.set_text(str(_counter))


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = not paused
		sceen_tree.set_input_as_handled()


func set_paused(value: bool) -> void:
	paused = value
	sceen_tree.paused = value
	pause_rect.visible = value


func _on_Timer_timeout() -> void:
	if _counter == 0:
		$Timer.stop()
		$Timer.queue_free()
		$TimeToStart.queue_free()
		return
	elif _counter == 1:
		set_paused(false)
		pause_rect.visible = false
		title.visible = true
		container_btn.visible = true
	
		_counter -= 1
		$TimeToStart.get_font("font").size = 42
		$TimeToStart.set_text('Go go go')
	else:
		_counter -= 1
		$TimeToStart.set_text(str(_counter))
