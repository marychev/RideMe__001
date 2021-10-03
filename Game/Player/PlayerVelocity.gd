extends Actor
class_name PlayerVelocity

# The current speed as `x` and the max-power of jump as `y`


func calculate_move_velocity(
	linear_velocity: Vector2, direction: Vector2, _speed: Vector2,
	is_jump_interrupted: bool
) -> Vector2:
	
	var out: = linear_velocity
	out.x = _speed.x  # * direction.x ## убивает релах
	out.y += gravity + get_physics_process_delta_time()
	
	if direction.y == -1.0:
		out.y = _speed.y * direction.y
		
	if is_jump_interrupted:
		out.y = 0.0
	
	return out


func calculate_stomp_velocity(
	linear_velocity: Vector2, 
	impulse: float
) -> Vector2:
	var out := linear_velocity
	out.y = -impulse
	return out


# Extra methods

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		-1.0 if Input.is_action_just_pressed("ui_select") and is_on_floor() else 0.0
	)


func max_value(value, max_value):
	return max_value if value > max_value else value


func positive_max_value(value, max_value):
	return 0 if value < 0 else max_value(value, max_value)
