extends BaseProgressDialog
class_name LevelProgressDialog

const RES_LEVEL_PROGRESS_DIALOG_ROWS = "res://Menu/LevelMenu/LevelProgressDialog/rows/"

onready var table: VBoxContainer = $Nine/TableContainer

var level_track_states = preload("res://Menu/scripts/LevelTrackStates.gd").new()


func _ready():
	._ready()
	
	title = "Progress %s"

	clean_table()
	fill_table()


# work on table

func clean_table() -> void:
	if is_instance_valid(table) and table.get_child_count() > 0:
		for row in table.get_children():
			table.remove_child(row)
			row.queue_free()


func fill_table() -> void:
	var track_cfg = preload("res://config/TrackCfg.gd").new()
	
	for level in track_cfg.get_tracks():
		if level_track_states.PASSED == level.state:
			add_passed_row_to_table(level)
		elif level_track_states.FAIL == level.state:
			add_fail_row_to_table(level)
		elif level_track_states.ACTIVE == level.state:
			add_active_row_to_table(level)
		elif level_track_states.PAY == level.state:
			add_pay_row_to_table(level)


func add_passed_row_to_table(level_map: Dictionary) -> void:
	add_row_to_table(load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "PassedRow.tscn"), level_map)


func add_active_row_to_table(level_map: Dictionary) -> void:
	add_row_to_table(load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "ActiveRow.tscn"), level_map)


func add_pay_row_to_table(level_map: Dictionary) -> void:
	add_row_to_table(load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "PayRow.tscn"), level_map)


func add_fail_row_to_table(level_map: Dictionary) -> void:
	add_row_to_table(load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "FailRow.tscn"), level_map)
	

func add_row_to_table(resource: Resource, level_map: Dictionary) -> void:
	if is_instance_valid(table):
		var row: Node = resource.instance()
		row.set_current_level(level_map.level)
		table.add_child(row)
