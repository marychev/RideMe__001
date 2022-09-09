extends "res://Game/GUI/controls/ControlBtn.gd"
class_name JumpBtn


func on_jump_process(dt: float, animation_name: String = "landing") -> void:
	on_pressed()
	
	animation_name = detect_collision_animation(animation_name)
	anim_player.play(animation_name)
	
	calc_power = player.power - (dt * player.acceleration.x / POWER_GO)
	player.set_power(calc_power)
	# player.set_height_jump(calc_speed)
	

func on_landing_process(dt: float, animation_name: String = "landing") -> void:
	if animation_name.empty():
		printerr("ERROR: on_landing_process")
		
	on_released()
	anim_player.stop()
