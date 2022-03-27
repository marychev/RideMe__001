extends Level_0
class_name Level_3


func _init():
	ID = 3
	var section: = track_cfg.get_section(ID)
	.init_level_track(section, ID)
	

func _ready():
	do_rain()


func do_rain():
	var sky: Sprite = get_parent().get_node('Background/sky')
	sky.modulate = Color('#98c3dc')
