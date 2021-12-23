extends Node

onready var level_track_states: LevelTrackStates = preload("res://Menu/scripts/LevelTrackStates.gd").new()

var current_level: BaseLevel
var level_0_map: Array


func _ready():
	level_0_map = Cfg.get_level_0_tracks()
	


class Cfg:
	const RES_TRACKS = "res://config/tracks.cfg"
	const RES_TRACKS_resource = "resource"
	const RES_TRACKS_state = "state"
	
	static func config(res_cfg):
		var config = ConfigFile.new()
		var err = config.load(res_cfg)
		if err != OK:
			return
		return config
		
	static func get_level_0_tracks():
		var config = Cfg.config(Cfg.RES_TRACKS)
		var store = []
		for track in config.get_sections():
			store.append({
				"level": load(config.get_value(track, Cfg.RES_TRACKS_resource)).instance(),
				"state": config.get_value(track, Cfg.RES_TRACKS_state)
			})
		return store

