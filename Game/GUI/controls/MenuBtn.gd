extends TouchScreenButton

onready var game_menu:Control = get_node("/root/Game/GUI/Canvas/GameScreen")


func _on_pressed() -> void:
	$AnimationPlayer.play("rotate")

func _on_released() -> void:
	game_menu.set_paused(true)
