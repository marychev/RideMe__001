extends Area2D
class_name Hourgrass

onready var player: Player = get_node(PathData.PATH_PLAYER)
onready var animation: AnimationPlayer = get_node("AnimationPlayer")


func _ready() -> void:
	set_physics_process(false)


func _on_body_entered(body: KinematicBody2D) -> void:
	if body.name == "Player":
		animation.play("fade_out")
		player_do_anim_success(body)
		timeout_do_anim_success()
		body.get_node('AudioMove').set_stream(body.audio_colected)
		body.get_node('AudioMove').play()
		set_value_of_time_level()
		PlayerData.set_time_level_count(body)


func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()


func _on_Hourgrass_body_shape_entered(
	body_id: int, body: Node, body_shape: int, local_shape: int
) -> void:
	player_do_anim_success(body)


func player_do_anim_success(player: KinematicBody2D) -> void:
	player.anim_player.play('success')


func timeout_do_anim_success() -> void:
	var timeout_animation: AnimationPlayer = get_node(PathData.PATH_TIMEOUT + "/AnimationPlayer")
	if timeout_animation.current_animation != 'success':
		timeout_animation.play('success')


func get_value_of_time_level() -> int:
	if GameData.current_track:
		return GameData.current_track.init_time_level
	return -1


func set_value_of_time_level() -> void:
	var value_of_time_level = get_value_of_time_level()
	PlayerData.time_level += value_of_time_level
