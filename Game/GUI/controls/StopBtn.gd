extends "res://Game/GUI/controls/ControlBtn.gd"
class_name StopBtn


func on_stop_process(dt: float) -> void:
	on_pressed()
	
	anim_player.stop()
	
	var stop_value = player.max_speed
	var allow_back_speed = -(stop_value / 2)
	
	if player.speed.x > allow_back_speed:
		player.set_speed(player.speed.x - dt * stop_value)
	else:
		player.set_speed(allow_back_speed)

	player.set_power(player.power + (dt * player.max_power))


func on_stop_released(dt: float) -> void:
	on_released()
	player.set_speed(2 * dt)
