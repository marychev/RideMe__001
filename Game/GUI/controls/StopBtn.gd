extends "res://Game/GUI/controls/ControlBtn.gd"
class_name StopBtn


func on_stop_process(dt: float) -> void:
	on_pressed()
	
	AnimPlayer.stop()
	Player.set_speed(Player.speed.x - (dt * (Player.max_power+Player.power)))
	Player.set_power(Player.power + (dt * Player.max_power))
	
func on_stop_released() -> void:
	on_released()
