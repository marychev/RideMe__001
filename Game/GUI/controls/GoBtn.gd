extends "res://Game/GUI/controls/ControlBtn.gd"
class_name GoBtn


func on_go_process(dt: float, animation_name: String = "go") -> void:
	on_pressed()
	
	animation_name = detect_collision_animation(animation_name)
	anim_player.play(animation_name)
	
	player.set_power(player.power - (dt * player.max_power/4))
	player.set_speed(player.speed.x + (dt * player.power))


func on_relax_process(dt: float, animation_name : String = "relax"):
	on_released()
	
	animation_name = detect_collision_animation(animation_name)
	anim_player.play(animation_name)
	
	player.set_power(player.power + dt * player.max_power/2)
	player.set_speed(player.speed.x - dt * (player.max_power/3))
