extends PlayerVelocity
class_name Player

export var max_speed: = 400.00
export var power: = 10.00
export var max_power: = 400.00

var mass: int = 130
var last_collision_name: = ""

onready var GUI: CanvasLayer = get_node(PlayerData.PATH_GUI)
onready var GameScreen: Control = get_node(PlayerData.PATH_GAME_SCREEN_PAUSE)
onready var SpeedBar: HBoxContainer = get_node(PlayerData.PATH_SPEED_BAR)
onready var PowerBar: HBoxContainer = get_node(PlayerData.PATH_POWER_BAR)
onready var JumpBtn: TouchScreenButton = get_node(PlayerData.PATH_JUMP_BTN)
onready var GoBtn: TouchScreenButton = get_node(PlayerData.PATH_GO_BTN)
onready var StopBtn: TouchScreenButton = get_node(PlayerData.PATH_STOP_BTN)

onready var AnimPlayer: AnimationPlayer = $AnimationPlayer


func _on_CollisionDetector_area_entered(area: Area2D) -> void:
	print('[_on_CollisionDetector_Area_entered]', area.name)
	var root = area.get_node('../')
	
	if 'Plank' in root.name:
		if Input.is_action_pressed("ui_select"):
			_velocity = calculate_stomp_velocity(_velocity, max_power/2 + power)


func _on_CollisionDetector_body_entered(body: Node) -> void:
	print("[_on_CollisionDetector_Body_entered]: ", body.name)
	if 'MovingPlatform' in body.name:
		$AnimationPlayer.stop()
		body.move_down(get_physics_process_delta_time(), mass)
	elif 'KSMan' in body.name:
		die(true)


func on_detect_collisions_process(delta):
		
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		
		if 'MovingPlatform' in collision.collider.name:
			collision.collider.move_down(delta, mass)
		elif 'StaticRock' in collision.collider.name:
			die_from(collision.collider.name)
		elif 'GirlBack' in collision.collider.name:
			collision.collider.collision_with(self)
			die_from(collision.collider.name)


# Processes

func _physics_process(delta: float):
	if Input.is_action_pressed("ui_right"):
		GoBtn.on_go_process(delta)
	elif Input.is_action_just_released("ui_right"):
		GoBtn.on_relax_process(delta)
	elif Input.is_action_pressed("ui_left"):
		StopBtn.on_stop_process(delta)
	elif Input.is_action_just_released("ui_left"):
		StopBtn.on_stop_released(delta)
	else:
		if speed.x < 1:
			GoBtn.on_wait_process(delta)
		else:
			GoBtn.on_relax_process(delta)

	if Input.is_action_pressed("ui_select"):
		JumpBtn.on_jump_process(delta)
	elif Input.is_action_just_released("ui_select"):
		JumpBtn.on_landing_process(delta)

	on_detect_collisions_process(delta)
	
	var is_jump_interrupted: = Input.is_action_just_released("ui_select") and _velocity.y < 0.0
	_velocity = calculate_move_velocity(_velocity, get_direction(), speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
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


func die_from(collision_name: String) -> void:
	if last_collision_name != collision_name:
		
		if 'StaticRock' in collision_name:
			PlayerData.lives -= 1
		elif 'GirlBack' in collision_name:
			PlayerData.lives /= 2

		last_collision_name = collision_name

	die()


func die(force: bool = false) -> void:
	if force: 
		PlayerData.lives = 0
	
	if PlayerData.lives <= 0:
		queue_free()
		
		var end_game_scr: String = "res://Game/GameScreen/EndGameScreen.tscn"
		get_tree().change_scene(end_game_scr)
