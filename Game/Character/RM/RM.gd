extends Area2D
class_name RM

var GUI: MarginContainer
var RMCounter: MarginContainer

onready var AnimPlayer: AnimationPlayer = get_node("AnimationPlayer")


func __force_init__(gui_scene: MarginContainer) -> void:
	GUI = gui_scene
	RMCounter = GUI.get_node("Canvas/Counters/RMCounter")


func _ready() -> void:
	set_physics_process(false)


func _on_body_entered(body):
	if body.name == "Player":
		AnimPlayer.play("fade_out")
		
		PlayerData.rms += 1
		PlayerData.score += int(PlayerData.rms) * 10
		
		# Animation player will remove it.
		## get_tree().queue_delete(self)


func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()
