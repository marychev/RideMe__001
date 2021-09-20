extends "res://Game/GUI/controls/ControlBtn.gd"
class_name JumpBtn


func on_jump_process(dt: float) -> void:
	on_pressed()
	AnimPlayer.play("landing")
	Player.set_power(Player.power - dt)


func on_landing_process(dt: float) -> void:
	on_released()
