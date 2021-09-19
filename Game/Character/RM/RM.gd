extends Area2D
class_name RM

var GUI: MarginContainer
var RMCounter: MarginContainer
var value: int

onready var AnimPlayer: AnimationPlayer = get_node("AnimationPlayer")


func __force_init__(gui_scene: MarginContainer) -> void:
	GUI = gui_scene
	RMCounter = GUI.get_node("Canvas/HBoxContainer/Counters/RMCounter")
	set_value_from_label()


func _ready() -> void:
	set_physics_process(false)


func _on_body_entered(body):
	if body.name == "Player":
		AnimPlayer.play("fade_out")
		set_value_from_label(1)
		# Animation player will remove it.
		## get_tree().queue_delete(self) 


func set_value_from_label(increment: int=0):
	var RMValue = RMCounter.get_node("Background/Value")
	
	value = int(RMValue.text)
	value += increment
	RMValue.text = str(value)
