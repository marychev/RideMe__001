class_name Cfg

const RES = "user://config/"

var path_file_cfg: String
var config: ConfigFile


func get_config() -> ConfigFile:
	var config = ConfigFile.new()
	var err = config.load(path_file_cfg)
	
	if err != OK:
		var message = "ERROR: Config file was not undefined!"
		push_error(message)
		print(message)

	return config
