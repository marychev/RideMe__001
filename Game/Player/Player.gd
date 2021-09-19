extends KinematicBody2D
class_name Player

export var gravity: = 42.0

# The current speed as `x` and the max-power of jump as `y`
export var speed: = Vector2(10.0, 800.0) 
export var max_speed: = 400.00

export var power: = 10.00
export var max_power: = 400.00

const FLOOR_NORMAL: = Vector2.UP

var _velocity: = Vector2.ZERO
var mass: int = 120
var GUI: MarginContainer
var SpeedBar: HBoxContainer
var PowerBar: HBoxContainer
var GoBtn: TouchScreenButton #  = GUI.get_node("Canvas/HBoxContainer/Bars/PowerBar")	
onready var AnimPlayer: AnimationPlayer = $AnimationPlayer


func force_init(gui_scene):
	GUI = gui_scene
	
	SpeedBar = GUI.get_node("Canvas/HBoxContainer/Bars/SpeedBar")
	PowerBar = GUI.get_node("Canvas/HBoxContainer/Bars/PowerBar")
	GoBtn = GUI.get_node("Canvas/ControlContainer/GoBtn")
	SpeedBar.force_init(self)
	PowerBar.force_init(self)


# EventPlayer

func on_go_process(dt):
	AnimPlayer.play("go")
	set_power(power - (dt * max_power/4))
	set_speed(speed.x + (dt * power))


func on_wait_process(dt: float):
	AnimPlayer.play("wait")
	set_power(power + dt * (max_power))
	set_speed(0)


func on_relax_process(dt: float):
	AnimPlayer.play("relax")
	set_power(power + dt * max_power/2)
	set_speed(speed.x - dt * (max_power/2))
	

func on_jump_process(dt: float):
	AnimPlayer.play("landing")
	set_power(power - dt)


func _on_CollisionDetector_area_entered(area: Area2D) -> void:
	#print('[_on_CollisionDetector_Area_entered]')
	#print(area.name, ': , root: ', area.get_node('../').name)
	
	var root = area.get_node('../')
	if 'Plank' in root.name:
		if Input.is_action_pressed("ui_select"):
			_velocity = calculate_stomp_velocity(_velocity, max_power + power)


func _on_CollisionDetector_body_entered(body: Node) -> void:
	print("[_on_CollisionDetector_Body_entered]: ", body.name)
	if 'MovingPlatform' in body.name:
		AnimPlayer.stop()
		body.move_down(get_physics_process_delta_time(), mass)


func on_detect_collisions_process(delta):
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		# print('!!! on_detect_collisions_process: ', collision.collider.name)
		if 'MovingPlatform' in collision.collider.name:
			collision.collider.move_down(delta, mass)


# Processes

func _physics_process(delta: float):
	if Input.is_action_pressed("ui_right"):
		on_go_process(delta)
	elif Input.is_action_pressed("ui_left"):
		on_go_process(delta)
	else:
		if speed.x < 1:
			on_wait_process(delta)
		else:
			on_relax_process(delta)

	if Input.is_action_pressed("ui_select"):
		on_jump_process(delta)
		
	on_detect_collisions_process(delta)
	
	var is_jump_interrupted: = Input.is_action_just_released("ui_select") and _velocity.y < 0.0
	_velocity = calculate_move_velocity(_velocity, get_direction(), speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)


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
