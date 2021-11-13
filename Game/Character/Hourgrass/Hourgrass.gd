extends Area2D
class_name Hourgrass

onready var player: Player = get_node(PlayerData.PATH_PLAYER)
onready var animation: AnimationPlayer = get_node("AnimationPlayer")


func _ready() -> void:
	set_physics_process(false)


func _on_body_entered(body) -> void:
	if body.name == "Player":
		animation.play("fade_out")
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
	# if player.anim_player.current_animation != 'success':
	player.anim_player.play('success')


func timeout_do_anim_success() -> void:
	var timeout_animation: AnimationPlayer = get_node(PlayerData.PATH_TIMEOUT + "/AnimationPlayer")
	if timeout_animation.current_animation != 'success':
		timeout_animation.play('success')


func get_value_of_time_level(level_num: float) -> int:
	if player.current_level:
		return player.current_level.INIT_TIME_LEVEL
	return -1


func set_value_of_time_level(level_num: float) -> void:
	var value_of_time_level = get_value_of_time_level(level_num)
	PlayerData.time_level += value_of_time_level
