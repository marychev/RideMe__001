extends BaseProgressDialog
class_name LevelProgressDialog

const RES_LEVEL_PROGRESS_DIALOG_ROWS = "res://Menu/LevelMenu/LevelProgressDialog/rows/"

onready var table: VBoxContainer = $Nine/TableContainer

var level_track_states = preload("res://Menu/scripts/LevelTrackStates.gd").new()


func _ready():
	._ready()
	
	title = "Progress %s"
	
	var track_cfg = load("res://config/TrackCfg.gd").new()
	for level in track_cfg.get_tracks():
		if level_track_states.PASSED == level.state:
			add_passed_row_to_table(level)
			print("passed: ", level)
		elif level_track_states.ACTIVE == level.state:
			add_active_row_to_table(level)
			print("active: ", level)
		elif level_track_states.PAY == level.state:
			add_pay_row_to_table(level)
			print("pay: ", level)


# work on table 

func add_passed_row_to_table(level_map: Dictionary) -> void:
	add_row_to_table(load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "PassedRow.tscn"), level_map)


func add_active_row_to_table(level_map: Dictionary) -> void:
	add_row_to_table(load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "ActiveRow.tscn"), level_map)


func add_pay_row_to_table(level_map: Dictionary) -> void:
	add_row_to_table(load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "PayRow.tscn"), level_map)


func add_row_to_table(resource: Resource, level_map: Dictionary) -> void:
	var row: Node = resource.instance()
	row.set_current_level(level_map.level)
	table.add_child(row)
