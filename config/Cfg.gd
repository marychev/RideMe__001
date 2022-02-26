class_name Cfg

const RES = "user://"
const KEY_SECTION = "_section"

var prefix: String  		# Example: LevelTrack
var path_file_cfg: String
var config: ConfigFile


func get_section(id_str) -> String:
	return "%s_%s" % [prefix.strip_edges(), id_str]


func get_config() -> ConfigFile:
	config = ConfigFile.new()
	var err = config.load(path_file_cfg)
	
	if err != OK:
		var message = "ERROR: " + str(err) + ". Config file was not undefined!\n" + path_file_cfg
		push_error(message)
		print(message)

	return config


func clear() -> void:
	config.clear()
	config.save(path_file_cfg)


func as_dict(section: String) -> Dictionary:
	return {}


func get_all() -> Array:
	var store = []
	for section in config.get_sections():
		store.append(as_dict(section))
	return store
