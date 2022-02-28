extends Node

var current_level: Level_0
var current_track: Level_0


func _ready():
	var track_cfg: TrackCfg = load(PathData.TRACK_MODEL).new()
	
	var track_resource: String
	var level_resource: String
	var level_id: int
	
	print("INIT GAME LEVEL AND TRACK")
	for section in track_cfg.config.get_sections():
		if track_cfg.get_state(section) == LevelTrackStates.ACTIVE:
			track_resource = track_cfg.get_resource(section)
			level_id = track_cfg.get_level_id(section)
	
	if not level_id:
		for section in track_cfg.config.get_sections():
			if track_cfg.get_state(section) == LevelTrackStates.FAIL:
				track_resource = track_cfg.get_resource(section)
				level_id = track_cfg.get_level_id(section)
	if not level_id:
		for section in track_cfg.config.get_sections():
			if track_cfg.get_state(section) == LevelTrackStates.PASSED:
				track_resource = track_cfg.get_resource(section)
				level_id = track_cfg.get_level_id(section)
	
	if level_id >= 0:
		for _as_level in track_cfg.get_tracks(level_id):
			
			print(level_id, _as_level.id, "<<<")
			
			if level_id == _as_level.id:
				level_resource = _as_level.resource
				GameData.current_level = load(level_resource).instance()
				break

	if not track_resource.empty():
		GameData.current_track = load(track_resource).instance()
