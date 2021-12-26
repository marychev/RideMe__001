extends Node2D
class_name BaseLevel  # via BaseModelView

var level_cfg: LevelCfg = preload("res://config/LevelCfg.gd").new()
var track_cfg: TrackCfg = preload("res://config/TrackCfg.gd").new()
var player_track_cfg: PlayerTrackCfg = preload("res://config/PlayerTrackCfg.gd").new()

var SECTION: String

var num_win: int
var init_time_level: int
var price: int
var level:int 
var track:int 

var title: String
var texture: Resource
var issue: String

var has_win: bool


func _init():
	SECTION = "LevelTrack_Train"
	
	title = 'Train '
	level = level_cfg.get_id("Level_0")
	num_win = track_cfg.get_num_win(SECTION)
	init_time_level = track_cfg.get_init_time_level(SECTION)
	price = track_cfg.get_price(SECTION)
	track = track_cfg.get_id(SECTION)
	issue = track_cfg.get_issue(SECTION) % num_win
	texture = load(track_cfg.get_texture(SECTION))

	has_win = false



func are_you_win(hourgrass_count: int = PlayerData.time_level_count) -> bool:
	has_win = hourgrass_count == num_win
	return has_win
