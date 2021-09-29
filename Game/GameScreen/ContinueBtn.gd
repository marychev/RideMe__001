extends Button

onready var game_menu:Control = get_node("/root/Game/GUI/Canvas/GameScreen")


func _on_button_up() -> void:
	game_menu.set_paused(false)
