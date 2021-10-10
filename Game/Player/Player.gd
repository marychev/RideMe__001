extends PlayerVelocity
class_name Player

export var max_speed: = 400.00
export var power: = 10.00
export var max_power: = 400.00

var mass: int = 130

onready var GUI: CanvasLayer = get_node(PlayerData.PATH_GUI)
onready var GameScreen: Control = get_node(PlayerData.PATH_GAME_SCREEN_PAUSE)
onready var SpeedBar: HBoxContainer = get_node(PlayerData.PATH_SPEED_BAR)
onready var PowerBar: HBoxContainer = get_node(PlayerData.PATH_POWER_BAR)
onready var JumpBtn: TouchScreenButton = get_node(PlayerData.PATH_JUMP_BTN)
onready var GoBtn: TouchScreenButton = get_node(PlayerData.PATH_GO_BTN)
onready var StopBtn: TouchScreenButton = get_node(PlayerData.PATH_STOP_BTN)

onready var anim_player: AnimationPlayer = $AnimationPlayer


func _on_CollisionDetector_area_entered(area: Area2D) -> void:
	print('[_on_CollisionDetector_Area_entered]', area.name)
	var root = area.get_node('../')
	
	if 'Plank' in root.name:
		if Input.is_action_pressed("ui_select"):
			_velocity = calculate_stomp_velocity(_velocity, max_power/2 + power)


func _on_CollisionDetector_body_entered(body: Node) -> void:
	print("[_on_CollisionDetector_Body_entered]: ", body.name)
	if 'MovingPlatform' in body.name:
		anim_player.stop()
		body.move_down(get_physics_process_delta_time(), mass)
	elif 'KSMan' in body.name:
		die(true)


func on_detect_collisions_process(delta):
	for i in get_slide_count():
		var collision = get_slide_collision(i)

		if 'MovingPlatform' in collision.collider.name:
			collision.collider.move_down(delta, mass)


func detect_landing_animation(current_animation_name: String) -> String:
	if not is_on_floor():
		current_animation_name = "landing"
	return current_animation_name


func get_input(delta: float):
	var animation_name = ""
	
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
	
	var is_jump_interrupted: = Input.is_action_just_released("ui_select") and _velocity.y < 0.0
	_velocity = calculate_move_velocity(_velocity, get_direction(), speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
	modulate = Color(0.8, 0, 0.1) if PlayerData.time_level < 3 else Color(1, 1, 1) 

	if position.y > 2000:
		die(true)


# set

func set_power(val):
	power = positive_max_value(val, max_power)
	if PowerBar:
		PowerBar.set_progress_player()


func set_speed(val_x = null):
	if val_x:
		speed.x = max_value(val_x, max_speed)
	if SpeedBar:
		SpeedBar.set_progress_player()


func die(force: bool = false) -> void:
	if force: 
		PlayerData.lives = 0
	
	# todo: need to fix
	if PlayerData.lives <= 0:
		# PlayerData.time_level = PlayerData.gui_time.time
		
		queue_free()
		
		var end_game_scr: String = "res://Game/GameScreen/EndGameScreen.tscn"
		get_tree().change_scene(end_game_scr)
