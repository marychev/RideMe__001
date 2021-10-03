extends "res://Game/GUI/controls/ControlBtn.gd"
class_name JumpBtn


func on_jump_process(dt: float) -> void:
	on_pressed()
	anim_player.play("landing")
	player.set_power(player.power - dt)


func on_landing_process(dt: float) -> void:
	on_released()
