extends Cfg
class_name TrackCfg

const FILE = "tracks.cfg"

const KEY_ID = "id"
const KEY_LEVEL = "level"
const KEY_ISSUE = "issue"
const KEY_RESOURCE = "resource"
const KEY_STATE = "state"
# texture = "res://Game/Level/assets/mountains.png"
const KEY_TEXTURE = "texture"
const KEY_NUM_WIN = "num_win"
const KEY_INIT_TIME_LEVEL = "init_time_level"
const KEY_PRICE = "price"


func _init():
	path_file_cfg = RES + FILE
	config = get_config()


# getters

func get_id(track) -> int:
	return config.get_value(track, KEY_ID)

func get_resource(track) -> String:
	# resource = "res://Game/Level/Level_Train/Level_Train.tscn"
	return config.get_value(track, KEY_RESOURCE)

func get_level(track) -> BaseLevel:
	return load(get_resource(track)).instance()

func get_issue(track) -> int:
	return config.get_value(track, KEY_ISSUE)

func get_state(track) -> LevelTrackStates:
	return config.get_value(track, KEY_STATE)

func get_texture(track) -> String:
	# texture = "res://Game/Level/assets/mountains.png"
	return config.get_value(track, KEY_TEXTURE)

func get_num_win(track) -> int:
	return config.get_value(track, KEY_NUM_WIN)
	
func get_init_time_level(track) -> int:
	return config.get_value(track, KEY_INIT_TIME_LEVEL)

func get_price(track) -> int:
	return config.get_value(track, KEY_PRICE)


# metthods

func get_tracks():
	var store = []
	for track in config.get_sections():
		store.append({
			KEY_LEVEL: get_level(track),
			KEY_STATE: config.get_value(track, KEY_STATE)
		})
	return store
