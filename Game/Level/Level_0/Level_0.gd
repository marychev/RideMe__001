extends Node2D
class_name Level_0

# Keys
var ID: int
var issue: String
var num_win: int
var init_time_level: int
var price: int
var track_id: int 
var texture: Resource
var resource: String

# Level's keys
var level_id:int 
var title: String

var has_win: bool

var level_cfg: LevelCfg = load(PathData.LEVEL_MODEL).new()
var track_cfg: TrackCfg = load(PathData.TRACK_MODEL).new()
var player_track_cfg: PlayerTrackCfg = load(PathData.PLAYER_TRACK_MODEL).new()


func _init() -> void:
	ID = 0
	
	var section: = get_section()
	
	if track_cfg.get_id(section) != null:
		level_id = track_cfg.get_level_id(section)
		title = level_cfg.get_title(level_cfg.get_section(level_id))
		num_win = track_cfg.get_num_win(section)
		init_time_level = track_cfg.get_init_time_level(section)
		price = track_cfg.get_price(section)
		track_id = track_cfg.get_id(section)
		issue = track_cfg.get_issue(section)
		resource = track_cfg.get_resource(section)
		texture = load(track_cfg.get_texture(section))

	has_win = false


func get_section() -> String:
	return "%s_%s" % [track_cfg.prefix, ID]


func are_you_win(hourgrass_count: int = PlayerData.time_level_count) -> bool:
	has_win = hourgrass_count == num_win
	return has_win
