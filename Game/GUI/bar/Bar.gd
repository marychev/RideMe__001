extends HBoxContainer
class_name Bar

onready var player: Player = get_node(PlayerData.PATH_PLAYER)


func do_or_stop_animation_danger(value, max_value):
	if value < max_value / 4:
		$AnimationPlayer.play("danger")
	else:
		modulate = Color(1, 1, 1, 1)
		$AnimationPlayer.stop()
