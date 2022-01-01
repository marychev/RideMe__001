extends Cfg
class_name TrackCfg

const FILE = "tracks.cfg"

const KEY_ID = "id"
const KEY_LEVEL = "level"
const KEY_ISSUE = "issue"
const KEY_RESOURCE = "resource"
const KEY_STATE = "state"
const KEY_TEXTURE = "texture"
const KEY_NUM_WIN = "num_win"
const KEY_INIT_TIME_LEVEL = "init_time_level"
const KEY_PRICE = "price"


func _init():
	prefix = "LevelTrack"
	path_file_cfg = RES + FILE
	config = get_config()


# getters

func get_id(section: String) -> int:
	return config.get_value(section, KEY_ID)

func get_resource(section: String) -> String:
	return config.get_value(section, KEY_RESOURCE)

func get_level(section: String) -> Node2D:
	# print("section: ", section)
	#var res = load(get_resource(section)).instance()
	#print(typeof(res))
	return load(get_resource(section)).instance()

func get_issue(section: String) -> String:
	return config.get_value(section, KEY_ISSUE)

func get_state(section: String) -> int:
	return config.get_value(section, KEY_STATE)

func get_texture(section: String) -> String:
	return config.get_value(section, KEY_TEXTURE)

func get_num_win(section: String) -> int:
	return config.get_value(section, KEY_NUM_WIN)
	
func get_init_time_level(section: String) -> int:
	return config.get_value(section, KEY_INIT_TIME_LEVEL)

func get_price(section: String) -> int:
	return config.get_value(section, KEY_PRICE)


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



