extends Actor
class_name BasePlayer

var player_bike = PlayerData.player_bike

var max_speed: float = player_bike.max_speed
var max_height_jump: float = player_bike.max_height_jump
var power: float = player_bike.power
var max_power: float = player_bike.max_power

onready var GUI: CanvasLayer = get_node(PathData.PATH_GUI)
onready var GameScreen: Control = get_node(PathData.PATH_GAME_SCREEN_PAUSE)
onready var SpeedBar: HBoxContainer = get_node(PathData.PATH_SPEED_BAR)
onready var PowerBar: HBoxContainer = get_node(PathData.PATH_POWER_BAR)
onready var JumpBtn: TouchScreenButton = get_node(PathData.PATH_JUMP_BTN)
onready var GoBtn: TouchScreenButton = get_node(PathData.PATH_GO_BTN)
onready var StopBtn: TouchScreenButton = get_node(PathData.PATH_STOP_BTN)
onready var anim_player: AnimationPlayer = $AnimationPlayer

# The current speed as `x` and the max-power of jump as `y`

func calculate_move_velocity(
	linear_velocity: Vector2, direction: Vector2, _speed: Vector2,
	is_jump_interrupted: bool
) -> Vector2:
	var out := linear_velocity
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


# setters

func set_power(val):
	power = positive_max_value(val, max_power)
	if PowerBar:
		PowerBar.set_progress_player()


func set_speed(val_x = null):
	if val_x:
		speed.x = max_value(val_x, max_speed)
	if SpeedBar:
		SpeedBar.set_progress_player()


func set_height_jump(val_y = null):
	if val_y:
		speed.y = max_value(val_y, max_height_jump)


# Extra methods

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		-1.0 if Input.is_action_just_pressed("ui_select") and is_on_floor() else 0.0
	)


func max_value(value, max_value):
	if value is Vector2:
		value = value.x
	return max_value if value > max_value else value



func positive_max_value(value, max_value):
	return 0 if value < 0 else max_value(value, max_value)
