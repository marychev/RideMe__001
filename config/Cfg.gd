class_name Cfg

const RES = "user://data/"
const KEY_SECTION = "_section"

var prefix: String
var path_file_cfg: String
var config: ConfigFile


func get_section(id: int) -> String:
	return "%s_%s" % [prefix, id]
		

func get_config() -> ConfigFile:
	config = ConfigFile.new()
	var err = config.load(path_file_cfg)
	
	if err != OK:
		var message = "ERROR: Config file was not undefined!"
		push_error(message)
		print(message)
		
	return config
