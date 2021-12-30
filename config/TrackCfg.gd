extends Cfg
class_name TrackCfg

const FILE = "test_tracks.cfg"

const KEY_ID = "id"
# resource = "res://Game/Level/Level_Train/Level_Train.tscn"
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
	prefix = "LevelTrack"
	path_file_cfg = RES + FILE
	config = get_config()


# getters

func get_id(track) -> int:
	return config.get_value(track, KEY_ID)

func get_resource(track) -> String:
	return config.get_value(track, KEY_RESOURCE)

func get_level(track):
	return load(get_resource(track)).instance()

func get_issue(track) -> String:
	return config.get_value(track, KEY_ISSUE)

func get_state(track) -> int:
	return config.get_value(track, KEY_STATE)

func get_texture(track) -> String:
	return config.get_value(track, KEY_TEXTURE)

func get_num_win(track) -> int:
	return config.get_value(track, KEY_NUM_WIN)
	
func get_init_time_level(track) -> int:
	return config.get_value(track, KEY_INIT_TIME_LEVEL)

func get_price(track) -> int:
	return config.get_value(track, KEY_PRICE)


func get_as_dict(section: String) -> Dictionary:
	return {
		KEY_LEVEL: get_level(section),
		KEY_STATE: get_state(section)
	}


func get_tracks() -> Array:
	var store = []
	for section in config.get_sections():
		store.append(get_as_dict(section))
	return store


# metthods

func create(
	id: int,
	level: int, 
	issue: String,
	resource: String,
	texture: String,
	num_win: int,
	init_time_level: int,
	price: int = 0,
	state: int = LevelTrackStates.PAY
) -> int:

	var section = get_section(id)
	
	config.set_value(section, KEY_ID, id)
	config.set_value(section, KEY_LEVEL, level)
	config.set_value(section, KEY_ISSUE, issue)
	config.set_value(section, KEY_RESOURCE, resource)
	config.set_value(section, KEY_STATE, state)
	config.set_value(section, KEY_TEXTURE, texture)
	config.set_value(section, KEY_NUM_WIN, num_win)
	config.set_value(section, KEY_INIT_TIME_LEVEL, init_time_level)
	config.set_value(section, KEY_PRICE, price)
	
	return config.save(path_file_cfg)


func set_state(current_level_SECTION: String, state: int):
	config.set_value(current_level_SECTION, KEY_STATE, state)
	config.save(path_file_cfg)



