extends Level_0
class_name Level_3


func _init():
	ID = 3
	var section: = track_cfg.get_section(ID)
	.init_level_track(section, ID)
