extends Level_0
class_name Level_1


func _init():
	ID = 1
	
	var section: = track_cfg.get_section(ID)
	if track_cfg.get_id(section):
		level_id = track_cfg.get_level_id(section)
		title = level_cfg.get_title(level_cfg.get_section(ID))
		num_win = track_cfg.get_num_win(section)
		init_time_level = track_cfg.get_init_time_level(section)
		price = track_cfg.get_price(section)
		track_id = track_cfg.get_id(section)
		issue = track_cfg.get_issue(section)
		resource = track_cfg.get_resource(section)
		texture = load(track_cfg.get_texture(section))

