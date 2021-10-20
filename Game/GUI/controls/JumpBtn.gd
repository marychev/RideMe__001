extends "res://Game/GUI/controls/ControlBtn.gd"
class_name JumpBtn


func on_jump_process(dt: float, animation_name: String = "landing") -> void:
	on_pressed()
	
	animation_name = detect_collision_animation(animation_name)
	anim_player.play(animation_name)
	
	player.set_power(player.power - (player.power * dt))
	player.set_height_jump(player.speed.y + player.power)
	

func on_landing_process(dt: float, animation_name: String = "landing") -> void:
	on_released()
	anim_player.stop()
	
	player.set_power(player.power + (player.power * dt*2))
	print('[Warrning]: landing. Need via a const 600')
	player.set_height_jump(600)
