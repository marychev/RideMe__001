extends Level_1
class_name Level_2


func _init():
	ID = 2
	title = level_cfg.get_title(level_cfg.get_section(ID))
	
	var section: = track_cfg.get_section(ID)
	if track_cfg.get_id(section):
		num_win = track_cfg.get_num_win(section)
		init_time_level = track_cfg.get_init_time_level(section)
		price = track_cfg.get_price(section)
		track = track_cfg.get_id(section)
		issue = track_cfg.get_issue(section)
		texture = load(track_cfg.get_texture(section))
