extends "res://Game/GUI/controls/ControlBtn.gd"
class_name GoBtn


func on_go_process(dt: float, animation_name: String = "go") -> void:
	on_pressed()
	
	animation_name = detect_collision_animation(animation_name)
	anim_player.play(animation_name)
	
	calc_power = player.power - (dt * player.max_power / POWER_GO)
	player.set_power(calc_power)
	
	calc_speed = player.speed.x + (dt * player.power)
	player.set_speed(calc_speed)


func on_relax_process(dt: float, animation_name : String = "relax"):
	on_released()
	
	animation_name = detect_collision_animation(animation_name)
	anim_player.play(animation_name)
	
	calc_power = player.power + (dt * player.max_power / POWER_RELAX)
	player.set_power(calc_power)
	
	calc_speed = player.speed.x - (dt * player.power)
	player.set_speed(calc_speed)
