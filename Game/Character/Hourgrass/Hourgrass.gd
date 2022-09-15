extends Area2D
class_name Hourgrass

onready var player: Player = get_node(PathData.PATH_PLAYER)
onready var animation: AnimationPlayer = get_node("AnimationPlayer")


func _ready() -> void:
	set_physics_process(false)


func _on_body_entered(body: KinematicBody2D) -> void:
	if is_instance_valid(body) and body.name == "Player":
		animation.play("fade_out")
		player_do_anim_success(body)
		timeout_do_anim_success()
		body.get_node('AudioMove').set_stream(body.audio_colected)
		body.get_node('AudioMove').play()
		set_value_of_time_level()
		
		var res := PlayerData.set_time_level_count(body)
		assert(res != OK, "ERROR: Hourgrass _on_body_entered set_time_level_count")


func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()


func _on_Hourgrass_body_shape_entered(
	body_id: int, body: Node, body_shape: int, local_shape: int
) -> void:
	if body_id and body and body_shape and local_shape:
		player_do_anim_success(body)


func player_do_anim_success(_player: KinematicBody2D) -> void:
	if is_instance_valid(_player):
		player = _player
	player.anim_player.play(PlayerData.ANIMATION_SUCCESS)


func timeout_do_anim_success() -> void:
	var timeout_animation: AnimationPlayer = get_node(PathData.PATH_TIMEOUT + "/AnimationPlayer")
	if timeout_animation.current_animation != PlayerData.ANIMATION_SUCCESS:
		timeout_animation.play(PlayerData.ANIMATION_SUCCESS)


func get_value_of_time_level() -> int:
	if GameData.current_track:
		return GameData.current_track.init_time_level
	return -1


func set_value_of_time_level() -> void:
	var value_of_time_level = get_value_of_time_level()
	PlayerData.time_level += value_of_time_level
