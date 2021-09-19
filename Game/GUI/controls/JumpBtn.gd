extends TouchScreenButton


func on_pressed() -> void:
	modulate.a = 1
	Input.action_press("ui_select")
	

func on_released() -> void:
	modulate.a = 0.8
	Input.action_release("ui_select")
	

func _ready() -> void:
	connect("pressed", self, "on_pressed")
	connect("released", self, "on_released")

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
