extends KinematicBody2D
class_name Player

export var gravity: = 42.0

# The current speed as `x` and the max-power of jump as `y`

export var max_speed: = 400.00
export var power: = 10.00
export var max_power: = 400.00

const FLOOR_NORMAL: = Vector2.UP

var _velocity: = Vector2.ZERO
var mass: int = 120
var GUI: MarginContainer
var SpeedBar: HBoxContainer
var PowerBar: HBoxContainer
var JumpBtn: TouchScreenButton
var GoBtn: TouchScreenButton
var StopBtn: TouchScreenButton
var last_collision_name: = ""

onready var speed: = Vector2(10.0, 800.0) 
onready var AnimPlayer: AnimationPlayer = $AnimationPlayer


func __force_init__(gui_scene):
	GUI = gui_scene
	SpeedBar = GUI.get_node("Canvas/HBoxContainer/Bars/SpeedBar")
	PowerBar = GUI.get_node("Canvas/HBoxContainer/Bars/PowerBar")
	JumpBtn = GUI.get_node("Canvas/ControlContainer/JumpBtn")
	GoBtn = GUI.get_node("Canvas/ControlContainer/GoBtn")
	StopBtn = GUI.get_node("Canvas/ControlContainer/StopBtn")
	
	SpeedBar.force_init(self)
	PowerBar.force_init(self)
	JumpBtn.force_init(self)
	GoBtn.force_init(self)
	StopBtn.force_init(self)
	

func _on_CollisionDetector_area_entered(area: Area2D) -> void:
	print('[_on_CollisionDetector_Area_entered]', area.name)
	#print(area.name, ': , root: ', area.get_node('../').name)
	var root = area.get_node('../')
	
	if 'Plank' in root.name:
		if Input.is_action_pressed("ui_select"):
			_velocity = calculate_stomp_velocity(_velocity, max_power/2 + power)


func _on_CollisionDetector_body_entered(body: Node) -> void:
	print("[_on_CollisionDetector_Body_entered]: ", body.name)
	if 'MovingPlatform' in body.name:
		AnimPlayer.stop()
		body.move_down(get_physics_process_delta_time(), mass)
	

func on_detect_collisions_process(delta):
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		
		if 'MovingPlatform' in collision.collider.name:
			collision.collider.move_down(delta, mass)
		elif 'StaticRock' in collision.collider.name:
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
		StopBtn.on_stop_released()
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

# calculation

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


func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out := linear_velocity
	out.y = -impulse
	return out


# Extra methods

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		-1.0 if Input.is_action_just_pressed("ui_select") and is_on_floor() else 0.0
	)


func set_power(val):
	power = positive_max_value(val, max_power)
	if PowerBar:
		PowerBar.set_progress_player()


func set_speed(val_x = null):
	if val_x:
		speed.x = positive_max_value(val_x, max_speed)
	if SpeedBar:
		SpeedBar.set_progress_player()


func positive_max_value(value, max_value):
	if value < 0:
		return 0
	elif value > max_value:
		return max_value
	else:
		return value


func die_from(collision_name: String) -> void:
	if last_collision_name != collision_name:
		PlayerData.lives -= 1
		last_collision_name = collision_name
	die()


func die(force: bool = false) -> void:
	if force: 
		PlayerData.lives = 0
	
	if PlayerData.lives <= 0:
		queue_free()
		
		var end_game_scr: = "res://Game/GameScreen/EndGameScreen.tscn"
		get_tree().change_scene(end_game_scr)
