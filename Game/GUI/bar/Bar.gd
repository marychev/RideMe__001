extends HBoxContainer
class_name Bar

var path_data: PathData = preload("res://Autoload/PathData.gd").new()

onready var player: KinematicBody2D = get_node(path_data.PATH_PLAYER)


func do_or_stop_animation_danger(value, max_value):
	if value < max_value / 4:
		$AnimationPlayer.play("danger")
	else:
		modulate = Color(1, 1, 1, 1)
		$AnimationPlayer.stop()
