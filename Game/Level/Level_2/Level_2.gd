extends Level_0
class_name Level_2


func _init():
	ID = 2
	var section: = track_cfg.get_section(ID)
	.init_level_track(section, ID)
	
