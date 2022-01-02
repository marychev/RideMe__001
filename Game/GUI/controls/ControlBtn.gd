extends TouchScreenButton
class_name ControlBtn

const POWER_GO: int = 10
const POWER_RELAX: int = 4
const POWER_WAIT: int = 2

var calc_power: float
var calc_speed: float
# var path_data: PathData = preload("res://Autoload/PathData.gd").new()

onready var player: KinematicBody2D = get_node(PathData.PATH_PLAYER)
onready var anim_player: AnimationPlayer = player.get_node("./AnimationPlayer")


func on_wait_process(dt: float, animation_name: String = "wait"):
	animation_name = detect_collision_animation(animation_name)
	anim_player.play(animation_name)
	
	calc_power = player.power + (dt * player.max_power / POWER_WAIT)
	player.set_power(calc_power)
	
	calc_speed = 0
	player.set_speed(calc_speed)
	
	
func on_pressed() -> void:
	modulate.a = 1
	Input.action_press(action)
	

func on_released() -> void:
	modulate.a = 0.6
	Input.action_release(action)
	

func _ready() -> void:
	connect("pressed", self, "on_pressed")
	connect("released", self, "on_released")


func detect_collision_animation(animation_name: String) -> String:
	if anim_player.is_playing():
		if anim_player.current_animation == "collision":
			return "collision"
		elif anim_player.current_animation == "success":
			return "success"

	return animation_name


"""
	signal double_click_pressed
	signal double_click_released

	var _double_speed := 1000 * 0.25
	var _last_click := 0.0

	func double_click_detect() -> bool:
		var new_click: = OS.get_ticks_msec()
		if new_click - _last_click <= _double_speed:
			return true
			
		_last_click = new_click
		return false

	func on_double_click_pressed() -> void:
		Input.action_press("ui_select")

	func on_double_click_released() -> void:
		Input.action_release("ui_select")

	func _ready():
		...
		connect("double_click_released", self, "on_double_click_released")
"""
