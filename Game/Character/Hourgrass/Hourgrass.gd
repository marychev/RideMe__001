extends Area2D
class_name Hourgrass

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")


func _ready() -> void:
	set_physics_process(false)


func _on_body_entered(body) -> void:
	if body.name == "Player":
		anim_player.play("fade_out")
		player_do_anim_success(body)
		timeout_do_anim_success()
		set_value_of_time_level(0.0)
		PlayerData.set_time_level_count(body)


func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()


func _on_Hourgrass_body_shape_entered(
	body_id: int, body: Node, body_shape: int, local_shape: int
) -> void:
	player_do_anim_success(body)


func player_do_anim_success(player: KinematicBody2D) -> void:
	if player.anim_player.current_animation != 'success':
		player.anim_player.play('success')


func timeout_do_anim_success() -> void:
	var timeout_anim_player: AnimationPlayer = get_node(PlayerData.PATH_TIMEOUT + "/AnimationPlayer")
	if timeout_anim_player.current_animation != 'success':
		timeout_anim_player.play('success')


func get_value_of_time_level(level_num: float) -> int:
	if level_num in [0.0, 0.1]:
		return 20
	elif level_num in [0.2, 0.3, 0.4]:
		return 30
	return -1


func set_value_of_time_level(level_num: float) -> void:
	var value_of_time_level = get_value_of_time_level(level_num)
	PlayerData.time_level += value_of_time_level
