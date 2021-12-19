extends Button

var path_data: PathData = preload("res://Autoload/PathData.gd").new()

onready var game_menu: Control = get_node(path_data.PATH_GAME_SCREEN_PAUSE)


func _on_button_up() -> void:
	game_menu.set_paused(false)
