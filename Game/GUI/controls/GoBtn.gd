extends "res://Game/GUI/controls/ControlBtn.gd"
class_name GoBtn


func on_go_process(dt: float) -> void:
	on_pressed()
	
	AnimPlayer.play("go")
	Player.set_power(Player.power - (dt * Player.max_power/4))
	Player.set_speed(Player.speed.x + (dt * Player.power))


func on_relax_process(dt: float):
	on_released()
	
	AnimPlayer.play("relax")
	Player.set_power(Player.power + dt * Player.max_power/2)
	Player.set_speed(Player.speed.x - dt * (Player.max_power/2))
