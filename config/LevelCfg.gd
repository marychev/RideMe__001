extends Cfg
class_name LevelCfg

const FILE = "levels.cfg"

const KEY_ID = "id"
const KEY_TITLE = "title"
const KEY_PASSED_AT = "passed_at"


func _init():
	path_file_cfg = RES + FILE
	config = get_config()


# getters

func get_id(level) -> int:
	return config.get_value(level, KEY_ID)

func get_title(level) -> String:
	return config.get_value(level, KEY_TITLE)

func get_passed_at(level):
	return config.get_value(level, KEY_PASSED_AT)

