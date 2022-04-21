extends Level_0
class_name Level_2


func _init():
	ID = 2
	var section: = track_cfg.get_section(ID)
	.init_level_track(section, ID)
	

static func create_for_cfg() -> void:
	var resource = "res://Game/Level/Level_2/Level_2.tscn"
	var texture = "res://Game/Level/assets/mountains.png"
	var num_win = 10
	var init_time_level = 30
	var price = 10
	var issue: = "Collect the %s hourgrass."
	GameData.track_cfg.create(1, 2, issue, resource, texture, num_win, init_time_level, price)
