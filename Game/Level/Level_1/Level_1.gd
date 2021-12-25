extends BaseLevel
class_name Level_1


func _init():
	SECTION = "LevelTrack_1"
	
	level = level_cfg.get_id("Level_0")
	title = level_cfg.get_title("Level_0")
	
	num_win = track_cfg.get_num_win(SECTION)
	init_time_level = track_cfg.get_init_time_level(SECTION)
	price = track_cfg.get_price(SECTION)
	track = track_cfg.get_id(SECTION)
	issue = track_cfg.get_issue(SECTION) % num_win
	texture = load(track_cfg.get_texture(SECTION))
	
	
