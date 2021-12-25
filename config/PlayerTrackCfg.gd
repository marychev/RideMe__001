extends Cfg
class_name PlayerTrackCfg

const FILE = "player_tracks.cfg"

const KEY_ID = "id"
const KEY_TRACK = "track"
const KEY_PAID_AT = "paid_at"
const KEY_BEST_TIME_AT = "best_time_at"
const KEY_ATTEMPTS = "attempts"

var track_cfg: TrackCfg = load("res://config/TrackCfg.gd").new()


func _init():
	path_file_cfg = RES + FILE
	config = get_config()


# getters

func get_id(track) -> int:
	return config.get_value(track, KEY_ID)

func get_track(track) -> int:
	return config.get_value(track, KEY_TRACK)

func get_paid_at(track) -> String:
	return config.get_value(track, KEY_PAID_AT)

func get_best_time_at(track) -> String:
	return config.get_value(track, KEY_BEST_TIME_AT)

func get_attempts(track) -> Array:
	return config.get_value(track, KEY_ATTEMPTS)


# metthods
