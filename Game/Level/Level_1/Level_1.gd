extends BaseLevel
class_name Level_1


func _init():
	ID = 1
	title = level_cfg.get_title(level_cfg.get_section(1))
	
	var section: = track_cfg.get_section(ID)
	if track_cfg.get_id(section):
		num_win = track_cfg.get_num_win(section)
		init_time_level = track_cfg.get_init_time_level(section)
		price = track_cfg.get_price(section)
		track = track_cfg.get_id(section)
		issue = track_cfg.get_issue(section) % num_win
		texture = load(track_cfg.get_texture(section))

