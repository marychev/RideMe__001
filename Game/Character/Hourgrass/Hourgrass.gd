extends Area2D
class_name Hourgrass

onready var AnimPlayer: AnimationPlayer = get_node("AnimationPlayer")


func _ready() -> void:
	set_physics_process(false)


func _on_body_entered(body):
	if body.name == "Player":
		AnimPlayer.play("fade_out")
		
		PlayerData.time_level += 10
		PlayerData.score += 1


func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()
