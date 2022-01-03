extends ActiveRow
class_name FailRow


func _ready() -> void:
	$PlayBtn/Label.set_text("replay")


func set_current_level(level: Level_0) -> void:
	.set_current_level(level)
	
	if level:
		var player_track_cfg: PlayerTrackCfg = load(PathData.PLAYER_TRACK_MODEL).new()
		
		# var prefix = str(level.track)		if level.track < 0:			prefix = level.title
		# var section = "PlayerTrack_%s" % prefix.strip_edges()
		var section := player_track_cfg.get_section(level.track)
		
		var best_time_at = player_track_cfg.get_best_time_at(section)
		if best_time_at:
			$Time.set_text(best_time_at.replace(" ", ""))
