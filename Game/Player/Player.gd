extends BasePlayer
class_name Player

# the max height of a stopm with road area to broken bike
const HEIGHT_STOPM_ROAD = 10000

var mass: int = 108

var is_jumping = false
var align_speed = 0.4

var audio_go = preload("res://media/move/go.wav")
var audio_relax = preload("res://media/move/relax.wav")
var audio_stop = preload("res://media/move/stop.wav")
var audio_jump = preload("res://media/move/jump.wav")
var audio_broke = preload("res://media/move/broken.wav")
var audio_colected = preload("res://media/move/colected.wav")


func _ready() -> void:
	$Sprite.texture = PlayerData.player_bike.texture
	modulate = Color(1, 1, 1)
	$AudioMove.volume_db = 1


func _on_CollisionDetector_area_entered(area: Area2D) -> void:
	var root = area.get_node('../')
	if 'Plank' in root.name:
		if Input.is_action_pressed("ui_select"):
			_velocity = calculate_stomp_velocity(_velocity, max_power+power)


func on_detect_collisions_process(delta) -> void:
	for i in get_slide_count():
		var collision := get_slide_collision(i)
		var body := collision.collider
		
		if 'MovingPlatform' in body.name:
			body.move_down(delta)


func detect_landing_animation(current_animation_name: String) -> String:
	if not is_on_floor():
		current_animation_name = "landing"
	return current_animation_name


func get_input(delta: float) -> void:
	var animation_name = "undefined"
	
	var has_broke: bool = $AudioMove.stream and $AudioMove.stream.resource_path.get_file().get_basename() == "broken"
	var has_colected: bool = $AudioMove.stream and $AudioMove.stream.resource_path.get_file().get_basename() == "colected"
		
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
		
		has_broke = $AudioMove.stream and $AudioMove.stream.resource_path.get_file().get_basename() == "broken"
		has_colected = $AudioMove.stream and $AudioMove.stream.resource_path.get_file().get_basename() == "colected"
		if $AudioMove.playing == false:
			$AudioMove.play()

	elif Input.is_action_just_released("ui_right"):
		animation_name = detect_landing_animation("relax")
		GoBtn.on_relax_process(delta)
		
		if not has_colected or not has_colected:
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
		
		if not has_broke or not has_colected:
			$AudioMove.set_stream(audio_jump)
		
	elif Input.is_action_pressed("ui_select"):
		animation_name = detect_landing_animation("landing")
		JumpBtn.on_jump_process(delta, animation_name)

		if not has_broke or not has_colected:
			if $AudioMove.playing == false:
				$AudioMove.play()
			
	elif Input.is_action_just_released("ui_select"):
		animation_name = detect_landing_animation("landing")
		JumpBtn.on_landing_process(delta, animation_name)
		
		if not has_colected or not has_colected:
			$AudioMove.set_stream(audio_go)
		$AudioMove.play()

	
# Processes

func _physics_process(delta: float) -> void:
	get_input(delta)
	on_detect_collisions_process(delta)

	var is_jump_interrupted: bool = Input.is_action_just_released("ui_select") and _velocity.y < 0.0
	var direction: Vector2 = get_direction()
	var snap: Vector2 = Vector2.DOWN * 64 if !is_jumping else Vector2.ZERO
	
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide_with_snap(_velocity, snap, FLOOR_NORMAL, true)
	# _velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
	if is_on_floor():
		rotation = lerp(rotation, get_floor_normal().angle() + PI/2, align_speed)
		is_jumping = Input.is_action_just_pressed("ui_select")
	
	if anim_player.current_animation != 'collision':
		modulate = Color(1, 1, 1)

	if PlayerData.time_level < 5:
		if anim_player.current_animation != 'collision':
			anim_player.stop()
		anim_player.play('collision')
	
	
	if position.y > HEIGHT_STOPM_ROAD:
		var die_player = load(PathData.PATH_DIE_PLAYER).new()
		die_player.from_fell(self)


func _on_CollisionDetector_body_entered(body) -> void:
	if 'MovingPlatform' in body.name:
		body.has_move_up = false
		body.position.y += mass / 10


func _on_CollisionDetector_body_exited(body) -> void:
	if 'MovingPlatform' in body.name:
		body.has_move_up = true
		body.position.y -= mass / 10
