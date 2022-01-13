extends Cfg
class_name LevelCfg

const FILE = "levels.cfg"

const KEY_ID = "id"
const KEY_TITLE = "title"
const KEY_PASSED_AT = "passed_at"


func _init():
	prefix = "Level"
	path_file_cfg = RES + FILE
	config = get_config()


# getters

func as_dict(section: String) -> Dictionary:
	return {
		KEY_SECTION: section,
		KEY_ID: get_id(section), 
		KEY_TITLE: get_title(section), 
		KEY_PASSED_AT: get_passed_at(section), 
	}


func get_id(section: String) -> int:
	return config.get_value(section, KEY_ID)

func get_title(section: String) -> String:
	return config.get_value(section, KEY_TITLE)

func get_passed_at(section: String) -> String:
	return config.get_value(section, KEY_PASSED_AT)

func get_tracks() -> Array:
	var store = []
	for section in config.get_sections():
		store.append(as_dict(section))
	return []


# create

func create(
	id: int, 
	title: String, 
	passed_at: String = ""
) -> int:
	var section = get_section(id)
	config.set_value(section, KEY_ID, id)
	config.set_value(section, KEY_TITLE, title)
	config.set_value(section, KEY_PASSED_AT, passed_at)
	return config.save(path_file_cfg)

