extends Node

var current_level: Dictionary
var current_track: Level_0


func _ready():
	var track_cfg: TrackCfg = load(PathData.TRACK_MODEL).new()
	var level_cfg: LevelCfg = load(PathData.LEVEL_MODEL).new()
	
	var level_id: int
	var level_section: String
	var track_resource: String
	
	for section in track_cfg.config.get_sections():
		if track_cfg.get_state(section) in [LevelTrackStates.FAIL, LevelTrackStates.ACTIVE, LevelTrackStates.PASSED]:
			level_id = track_cfg.get_level_id(section)
			level_section = level_cfg.get_section(level_id)
			track_resource = track_cfg.get_resource(section)
			
			if not track_resource.empty():
				current_track = load(track_resource).instance()
				current_level = level_cfg.as_dict(level_section)
			
			break

	"""
			for _as_level in track_cfg.get_tracks(level_id):
				if level_id == _as_level.id:
					level_resource = _as_level.resource
					GameData.current_level = load(level_resource).instance()
					
					if not track_resource.empty():
						GameData.current_track = load(track_resource).instance()
						break
					break
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
			if level_id == _as_level.id:
				level_resource = _as_level.resource
				GameData.current_level = load(level_resource).instance()
				break

	if not track_resource.empty():
		GameData.current_track = load(track_resource).instance()
"""
