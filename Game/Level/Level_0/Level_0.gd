extends BaseLevel
class_name Level_0


func _init():
	ID = 0
	level = level_cfg.get_id("Level_0")
	title = level_cfg.get_title("Level_0")
	
	var section: = track_cfg.get_section(ID)
	
	num_win = track_cfg.get_num_win(section)
	init_time_level = track_cfg.get_init_time_level(section)
	price = track_cfg.get_price(section)
	track = track_cfg.get_id(section)
	issue = track_cfg.get_issue(section) % num_win
	texture = load(track_cfg.get_texture(section))

