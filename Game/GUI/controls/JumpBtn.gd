extends "res://Game/GUI/controls/ControlBtn.gd"
class_name JumpBtn


func on_jump_process(dt: float, animation_name: String = "landing") -> void:
	on_pressed()
	
	
	animation_name = detect_collision_animation(animation_name)
	
	print(anim_player.current_animation + '<- prew | next ->' + animation_name)
	
	anim_player.play(animation_name)

	player.set_power(player.power - dt)


func on_landing_process(dt: float, animation_name: String = "landing") -> void:
	on_released()
	anim_player.stop()
