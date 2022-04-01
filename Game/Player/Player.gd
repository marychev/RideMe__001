extends BasePlayer
class_name Player

var mass: int = 130

var audio_go = preload("res://media/move/go.wav")
var audio_relax = preload("res://media/move/relax.wav")
var audio_stop = preload("res://media/move/stop.wav")
var audio_jump = preload("res://media/move/jump.wav")
var audio_broke = preload("res://media/move/broke-bike.wav")


func _ready():
	$Sprite.texture = PlayerData.player_bike.texture
	modulate = Color(1, 1, 1)
	$AudioMove.volume_db = 1


func _on_CollisionDetector_area_entered(area: Area2D) -> void:
	# print('[_on_CollisionDetector_Area_entered]', area.name)
	var root = area.get_node('../')
	
	if 'Plank' in root.name:
		if Input.is_action_pressed("ui_select"):
			_velocity = calculate_stomp_velocity(_velocity, max_power+power)


func _on_CollisionDetector_body_entered(body: Node) -> void:
	# print("[_on_CollisionDetector_Body_entered]: ", body.name)
	if 'MovingPlatform' in body.name:
		body.move_down(get_physics_process_delta_time(), mass)
	#elif 'KSMan' in body.name:


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
	
	# Move right
	if Input.is_action_just_pressed("ui_right"):
		animation_name = detect_landing_animation("go")
		GoBtn.on_go_process(delta, animation_name)
		$AudioMove.set_stream(audio_go)
		if $AudioMove.playing == false:
			$AudioMove.play()
	elif Input.is_action_pressed("ui_right"):
		animation_name = detect_landing_animation("go")
		GoBtn.on_go_process(delta, animation_name)
		var has_broke = $AudioMove.stream and $AudioMove.stream.resource_path.get_file().get_basename() == "broke-bike"
		if not has_broke and $AudioMove.playing == false:
			$AudioMove.play()
	elif Input.is_action_just_released("ui_right"):
		animation_name = detect_landing_animation("relax")
		GoBtn.on_relax_process(delta)
		$AudioMove.set_stream(audio_relax)
		$AudioMove.play()
	
	# Move back
	elif Input.is_action_just_pressed("ui_left"):
		animation_name = detect_landing_animation("stop")
		StopBtn.on_stop_process(delta)
		$AudioMove.set_stream(audio_stop)
		$AudioMove.play()
	elif Input.is_action_pressed("ui_left"):
		animation_name = detect_landing_animation("stop")
		StopBtn.on_stop_process(delta)
	elif Input.is_action_just_released("ui_left"):
		animation_name = detect_landing_animation("relax")
		StopBtn.on_stop_released(delta)
	else:
		if speed.x < 1:
			animation_name = detect_landing_animation("wait")
			GoBtn.on_wait_process(delta, animation_name)
		else:
			animation_name = detect_landing_animation("relax")
			GoBtn.on_relax_process(delta, animation_name)
	
	# Move is not on floor. Jump / Landing
	if Input.is_action_just_pressed("ui_select"):
		animation_name = detect_landing_animation("landing")
		JumpBtn.on_jump_process(delta, animation_name)
		$AudioMove.set_stream(audio_jump)
		$AudioMove.play()
	elif Input.is_action_pressed("ui_select"):
		animation_name = detect_landing_animation("landing")
		JumpBtn.on_jump_process(delta, animation_name)
	elif Input.is_action_just_released("ui_select"):
		animation_name = detect_landing_animation("landing")
		JumpBtn.on_landing_process(delta, animation_name)
		$AudioMove.set_stream(audio_go)
		$AudioMove.play()
		
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
		var die_player = load(PathData.PATH_DIE_PLAYER).new()
		die_player.from_fell(self)
