extends MarginContainer
class_name GUI

var path_data: PathData = load("res://Autoload/PathData.gd").new()

onready var lives_value: Label = get_node(path_data.PATH_LIVES_COUNTER_VALUE)


func _ready() -> void:
	set_lives()
	print(GameData.current_level, "GUI")


func set_lives():
	lives_value.text = str(PlayerData.lives)
