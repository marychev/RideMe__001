extends TouchScreenButton


func set_modulate_a(action: String = 'pressed'):
	if action == 'pressed':
		modulate.a = 1
	else:
		modulate.a = 0.8


func on_pressed() -> void:
	set_modulate_a('pressed')
	Input.action_press("ui_right")


func on_released() -> void:
	set_modulate_a('released')
	Input.action_release("ui_right")


func _ready() -> void:
	connect("pressed", self, "on_pressed")
	connect("released", self, "on_released")
