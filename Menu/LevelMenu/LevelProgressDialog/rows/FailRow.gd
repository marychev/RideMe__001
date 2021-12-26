extends ActiveRow
class_name FailRow


func _ready() -> void:
	._ready()
	$PlayBtn/Label.set_text("replay")


func set_current_level(level: BaseLevel) -> void:
	.set_current_level(level)
	
	if level:
		var player_track_cfg = preload("res://config/PlayerTrackCfg.gd").new()
		
		var prefix = str(level.track)
		if level.track < 0:
			prefix = level.title
		
		var section = "PlayerTrack_%s" % prefix.strip_edges()
		var best_time_at = player_track_cfg.get_best_time_at(section)
		if best_time_at:
			$Time.set_text(best_time_at.replace(" ", ""))
