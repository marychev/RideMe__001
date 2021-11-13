extends BasePlayer
class_name Player

var mass: int = 130


func _on_CollisionDetector_area_entered(area: Area2D) -> void:
	# print('[_on_CollisionDetector_Area_entered]', area.name)
	var root = area.get_node('../')
	
	if 'Plank' in root.name:
		if Input.is_action_pressed("ui_select"):
			_velocity = calculate_stomp_velocity(_velocity, max_power+power)


func _on_CollisionDetector_body_entered(body: Node) -> void:
	# print("[_on_CollisionDetector_Body_entered]: ", body.name)
	if 'MovingPlatform' in body.name:
		anim_player.stop()
		body.move_down(get_physics_process_delta_time(), mass)
	elif 'KSMan' in body.name:
		var die_player = load(PlayerData.PATH_DIE_PLAYER).new()
		die_player.from_hir_person(self)
		
		__todo__()


func on_detect_collisions_process(delta):
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		# print('on_detect_collisions_process__ ',  collision.collider.name)
		if 'MovingPlatform' in collision.collider.name:
			collision.collider.move_down(delta, mass)
		# elif 'StaticRock' in collision.collider.name:  pass


func detect_landing_animation(current_animation_name: String) -> String:
	if not is_on_floor():
		current_animation_name = "landing"
	return current_animation_name


func get_input(delta: float):
	var animation_name = "undefined"
	
	if Input.is_action_pressed("ui_right"):
		animation_name = detect_landing_animation("go")
		GoBtn.on_go_process(delta, animation_name)
	elif Input.is_action_just_released("ui_right"):
		animation_name = detect_landing_animation("relax")
		GoBtn.on_relax_process(delta)
	elif Input.is_action_pressed("ui_left"):
		animation_name = detect_landing_animation("stop_DEV")
		StopBtn.on_stop_process(delta)
	elif Input.is_action_just_released("ui_left"):
		animation_name = detect_landing_animation("")
		StopBtn.on_stop_released(delta)
	else:
		if speed.x < 1:
			animation_name = detect_landing_animation("wait")
			GoBtn.on_wait_process(delta, animation_name)
		else:
			animation_name = detect_landing_animation("relax")
			GoBtn.on_relax_process(delta, animation_name)

	if Input.is_action_pressed("ui_select"):
		animation_name = detect_landing_animation("landing")
		JumpBtn.on_jump_process(delta, animation_name)
	elif Input.is_action_just_released("ui_select"):
		animation_name = detect_landing_animation("landing")
		JumpBtn.on_landing_process(delta, animation_name)


# Processes

func _physics_process(delta: float):
	get_input(delta)
	on_detect_collisions_process(delta)
	
	var is_jump_interrupted: = Input.is_action_just_released("ui_select") \
		and _velocity.y < 0.0
	
	_velocity = calculate_move_velocity(_velocity, get_direction(), speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
	if anim_player.current_animation != 'collision':
		modulate = Color(1, 1, 1)

	if PlayerData.time_level < 5:
		if anim_player.current_animation != 'collision':
			anim_player.stop()
		anim_player.play('collision')
	
	# Todo: Implement calculate the max height of a stopm with road area
	if position.y > 2000:
		var die_player = load(PlayerData.PATH_DIE_PLAYER).new()
		die_player.from_fell(self)


func __todo__():
	print('Todo:')
	print('1. Add collision via GirlBack instead')
	print()
