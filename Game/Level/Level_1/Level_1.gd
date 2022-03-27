extends Level_0
class_name Level_1


func _init():
	ID = 1
	var section: = track_cfg.get_section(ID)
	.init_level_track(section, ID)


func _ready():
	var sky: Sprite = get_parent().get_node('Background/sky')
	sky.modulate = Color('#e6e588')
