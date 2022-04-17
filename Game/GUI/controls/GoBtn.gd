extends "res://Game/GUI/controls/ControlBtn.gd"
class_name GoBtn


func on_go_process(dt: float, animation_name: String = "go") -> void:
	modulate_switcher()
	on_pressed()
	
	animation_name = detect_collision_animation(animation_name)
	anim_player.play(animation_name)
	
	calc_power = player.power - (dt * player.max_power / POWER_GO)
	player.set_power(calc_power)
	
	calc_speed = player.speed.x + (dt * player.power)
	player.set_speed(calc_speed)
	

func on_relax_process(dt: float, animation_name : String = "relax"):
	modulate_switcher()
	on_released()

	animation_name = detect_collision_animation(animation_name)
	anim_player.play(animation_name)
	
	calc_power = player.power + (dt * player.max_power / POWER_RELAX)
	player.set_power(calc_power)
	
	calc_speed = player.speed.x - (dt * player.power)
	player.set_speed(calc_speed)
	

func modulate_switcher() -> void:
	if player.power < player.max_power / 4:
		modulate = Color.red
	elif player.power < player.max_power / 2:
		modulate = Color.orange
	else:
		modulate = Color.white
