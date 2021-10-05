extends Button

onready var game_menu: Control = get_node(PlayerData.PATH_GAME_SCREEN_PAUSE)


func _on_button_up() -> void:
	game_menu.set_paused(false)
