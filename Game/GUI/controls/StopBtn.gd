extends TouchScreenButton


func on_pressed() -> void:
	modulate.a = 1
	Input.action_press("ui_left")
	

func on_released() -> void:
	modulate.a = 0.8
	Input.action_release("ui_left")
	

func _ready() -> void:
	connect("pressed", self, "on_pressed")
	connect("released", self, "on_released")
