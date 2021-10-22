extends "res://Game/GUI/controls/ControlBtn.gd"
class_name JumpBtn


func on_jump_process(dt: float, animation_name: String = "landing") -> void:
	on_pressed()
	
	animation_name = detect_collision_animation(animation_name)
	anim_player.play(animation_name)
	
	calc_power = player.power - (dt * player.max_power / POWER_GO)
	player.set_power(calc_power)
	
	calc_speed = player.speed.y + player.power
	player.set_height_jump(calc_speed)
	

func on_landing_process(dt: float, animation_name: String = "landing") -> void:
	on_released()
	anim_player.stop()
	
	calc_power = player.power + (player.power * dt * 2)
	player.set_power(calc_power)
	
	print('[Warrning]: landing. Need via a const 600')
	calc_speed = 600
	player.set_height_jump(calc_speed)
