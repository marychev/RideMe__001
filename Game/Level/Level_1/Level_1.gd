extends Level_0
class_name Level_1


func _init():
	ID = 1
	var section: = track_cfg.get_section(ID)
	.init_level_track(section, ID)
