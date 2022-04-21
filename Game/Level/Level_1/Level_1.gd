extends Level_0
class_name Level_1


func _init():
	ID = 1
	var section: = track_cfg.get_section(ID)
	.init_level_track(section, ID)


func _ready():
	var sky: Sprite = get_parent().get_node('Background/sky')
	sky.modulate = Color('#e6e588')


static func create_for_cfg() -> void:
	var resource = "res://Game/Level/Level_1/Level_1.tscn"
	var texture = "res://Game/Level/assets/mountains.png"
	var num_win = 5
	var init_time_level = 20
	var price = 2
	var issue: = "Collect the %s hourgrass."
	GameData.track_cfg.create(1, 1, issue, resource, texture, num_win, init_time_level, price)
