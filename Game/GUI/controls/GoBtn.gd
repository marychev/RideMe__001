extends "res://Game/GUI/controls/ControlBtn.gd"
class_name GoBtn


func on_go_process(dt: float) -> void:
	on_pressed()
	
	anim_player.play("go")
	player.set_power(player.power - (dt * player.max_power/4))
	player.set_speed(player.speed.x + (dt * player.power))


func on_relax_process(dt: float):
	on_released()
	
	anim_player.play("relax")
	player.set_power(player.power + dt * player.max_power/2)
	player.set_speed(player.speed.x - dt * (player.max_power/3))
