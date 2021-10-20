extends Area2D
class_name Hourgrass

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")


func _ready() -> void:
	set_physics_process(false)


func _on_body_entered(body):
	if body.name == "Player":
		anim_player.play("fade_out")
		
		player_do_anim_success(body)
		timeout_do_anim_success()
	
		PlayerData.time_level += 40
		PlayerData.score += 1


func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()


func _on_Hourgrass_body_shape_entered(body_id: int, body: Node, body_shape: int, local_shape: int) -> void:
	player_do_anim_success(body)


func player_do_anim_success(player: Player) -> void:
	if player.anim_player.current_animation != 'success':
		player.anim_player.play('success')


func timeout_do_anim_success() -> void:
	var timeout_anim_player: AnimationPlayer = get_node(PlayerData.PATH_TIMEOUT + "/AnimationPlayer")
	if timeout_anim_player.current_animation != 'success':
		timeout_anim_player.play('success')
