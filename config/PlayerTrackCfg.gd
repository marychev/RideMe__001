extends Cfg
class_name PlayerTrackCfg

const FILE:  = "player_tracks.cfg"

const KEY_ID: = "id"
const KEY_TRACK_ID: = "track_id"
const KEY_PAID_AT: = "paid_at"
const KEY_BEST_TIME_AT: = "best_time_at"
const KEY_ATTEMPTS: = "attempts"
const DEFAULT_BEST_TIME_AT: = "00:00:00"


func _init():
	prefix = "PlayerTrack"
	path_file_cfg = RES + FILE
	config = get_config()


# getters

func get_id(track) -> int:
	return config.get_value(track, KEY_ID)

func get_track(track) -> int:
	return config.get_value(track, KEY_TRACK_ID)

func get_paid_at(track) -> String:
	return config.get_value(track, KEY_PAID_AT)

func get_best_time_at(track) -> String:
	return config.get_value(track, KEY_BEST_TIME_AT)

func get_attempts(track) -> Array:
	return config.get_value(track, KEY_ATTEMPTS)


# setters

func set_best_time(current_track_SECTION: String, value: String) -> void:
	var player_track_SECTION = current_track_SECTION.replace("LevelTrack", prefix)
	var attempts = get_attempts(player_track_SECTION)
	attempts.append(value)
	
	var _best_time_at = attempts.min()
	if _best_time_at and _best_time_at > value:
		value = _best_time_at
		
	config.set_value(player_track_SECTION, KEY_BEST_TIME_AT, value)
	config.set_value(player_track_SECTION, KEY_ATTEMPTS, attempts)
	config.save(path_file_cfg)


# metthods

func create(track_section: String, player_track_section: String) -> int:
	config.set_value(player_track_section, KEY_TRACK_ID, get_id(track_section))
	config.set_value(player_track_section, KEY_PAID_AT, OS.get_datetime())
	config.set_value(player_track_section, KEY_BEST_TIME_AT, DEFAULT_BEST_TIME_AT)
	config.set_value(player_track_section, KEY_ATTEMPTS, [])
	return config.save(path_file_cfg)
