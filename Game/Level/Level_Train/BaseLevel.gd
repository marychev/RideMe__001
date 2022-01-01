extends Node2D
class_name BaseLevel  # via BaseModelView

# Keys
var ID: int
var issue: String
var num_win: int
var init_time_level: int
var price: int
var track:int 
var texture: Resource

# Level's keys
var level:int 
var title: String

var has_win: bool

var level_cfg: LevelCfg = load("res://config/LevelCfg.gd").new()
var track_cfg: TrackCfg = load("res://config/TrackCfg.gd").new()
var player_track_cfg: PlayerTrackCfg = preload("res://config/PlayerTrackCfg.gd").new()


func _init():
	ID = -1
	title = 'Train '
	
	var section: = "%s_%s" % [track_cfg.prefix, ID]
	
	num_win = track_cfg.get_num_win(section)
	init_time_level = track_cfg.get_init_time_level(section)
	price = track_cfg.get_price(section)
	track = track_cfg.get_id(section)
	issue = track_cfg.get_issue(section) % num_win
	texture = load(track_cfg.get_texture(section))

	has_win = false


func are_you_win(hourgrass_count: int = PlayerData.time_level_count) -> bool:
	has_win = hourgrass_count == num_win
	return has_win
