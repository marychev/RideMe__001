extends GoBtn
class_name JumpBtn


func on_jump_process(dt: float, animation_name: String = "landing") -> void:
	on_pressed()
	animation_name = detect_collision_animation(animation_name)
	anim_player.play(animation_name)
	
	set_go_power(dt)
	player.set_height_jump(player._velocity.y)
	

func on_landing_process(dt: float, animation_name: String = "landing") -> void:
	on_released()
	anim_player.stop()
