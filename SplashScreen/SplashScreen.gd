tool
extends TextureRect

export (String, FILE) var main_menu_tscn: = ""


func _ready():
	print("INSTAL GAME TO USER STORE")
	# create levels
	var level_cfg: LevelCfg = preload("res://config/LevelCfg.gd").new()
	level_cfg.create(0, "Mountains")
	level_cfg.create(1, "City")
	
	# create tracks
	var track_cfg: TrackCfg = preload("res://config/TrackCfg.gd").new()
	track_cfg.create(
		-1, 0, 
		"Collect the %s hourgrass!", 
		"res://Game/Level/Level_Train/Level_Train.tscn", 
		"res://Game/Level/assets/mountains.png", 
		2,  100)

	track_cfg.create(
		0, 0, 
		"Collect the %s hourgrass!", 
		"res://Game/Level/Level_0/Level_0.tscn", 
		"res://Game/Level/assets/mountains-bottom.png", 
		5, 20,  2)
	
	track_cfg.create(
		1, 0, 
		"Collect the %s hourgrass!", 
		"res://Game/Level/Level_1/Level_1.tscn",
		"res://Game/Level/assets/mountains-bottom.png", 
		20, 40,  120)


func _on_Start_pressed() -> void:
	get_tree().change_scene(main_menu_tscn)


func _get_configuration_warning() -> String:
	var msg: String = "Main Menu scene must be set "
	return msg if main_menu_tscn == "" else ""
