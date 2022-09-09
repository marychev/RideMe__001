extends "res://Game/GUI/controls/ControlBtn.gd"
class_name GoBtn


func on_go_process(dt: float, animation_name: String = "go") -> void:
	modulate_switcher()
	on_pressed()
	set_accelaration_power(dt)
	set_go_power(dt)
	animation_name = detect_collision_animation(animation_name)
	anim_player.play(animation_name)


func on_relax_process(dt: float, animation_name : String = "relax"):
	modulate_switcher()
	on_released()
	set_relax_power(dt)
	animation_name = detect_collision_animation(animation_name)
	anim_player.play(animation_name)


func set_accelaration_power(dt: float) -> void:
	var velocity_x := dt * ((player.max_power / POWER_GO) * 2)
	# if rotation == 0:
	# acceleration_power = player.max_power
	player.acceleration = player.transform.x * player.power/2
	
	# if player._velocity.x > 100.0 and velocity_x > 1.0: player._velocity.x -= velocity_x


func set_go_power(dt: float) -> void:
	var value = player.power - (dt * player.acceleration.x / POWER_GO)
	player.set_power(value)


func set_relax_power(dt: float) -> void:
	var value = player.power + (dt * player.max_power / POWER_RELAX)
	player.set_power(value)
	

func modulate_switcher() -> void:
	if player.power < player.max_power / POWER_RELAX:
		modulate = Color.red
	elif player.power < player.max_power / POWER_WAIT:
		modulate = Color.orange
	else:
		modulate = Color.white
