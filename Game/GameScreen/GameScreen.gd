extends Control
class_name GameScreen

onready var sceen_tree: = get_tree()
onready var pause_rect: ColorRect = get_node("PauseRect")
onready var title: Label = get_node("PauseRect/Title")
onready var container_btn: VBoxContainer = get_node("PauseRect/Container")
onready var player: KinematicBody2D = get_node(PlayerData.PATH_PLAYER)

var _counter: int = 3
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
	elif _counter == 1:
		set_paused(false)
		pause_rect.visible = false
		title.visible = true
		container_btn.visible = true
	
		$TimeToStart.get_font("font").size = 64
		
		var title = "Go go go\r\n%s" % player.current_level.title
		$TimeToStart.set_text(title)
		
		_counter -= 1
	else:
		_counter -= 1
		$TimeToStart.set_text(str(_counter))
