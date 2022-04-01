extends Area2D
class_name RM

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")


func _ready() -> void:
	set_physics_process(false)


func _on_body_entered(body: Player) -> void:
	if body.name == "Player":
		anim_player.play("fade_out")
		player_do_anim_success(body)
		rm_counter_do_anim_success()
		body.get_node('AudioMove').set_stream(body.audio_colected)
		body.get_node('AudioMove').play()
		PlayerData.rms += 1
		


func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()


func player_do_anim_success(player: Player) -> void:
	if player.anim_player.current_animation != 'success':
		player.anim_player.play('success')


func rm_counter_do_anim_success() -> void:
	var _anim_player: AnimationPlayer = get_node(PathData.PATH_RMS_COUNTER + '/AnimationPlayer')
	if _anim_player.current_animation != 'success':
		_anim_player.play('success')
