extends BaseProgressDialog
class_name LevelProgressDialog

const RES_LEVEL_PROGRESS_DIALOG_ROWS = "res://Menu/LevelMenu/LevelProgressDialog/rows/"

onready var table: VBoxContainer = $Nine/TableContainer


func _ready():
	._ready()
	
	title = "<Progress %s>"
	
	for level in GameData.level_0_map:
		add_passed_row_to_table(level)
		add_active_row_to_table(level)
		add_pay_row_to_table(level)


# work on table 

func add_passed_row_to_table(level_map: Dictionary) -> void:
	if level_map.is_passed and level_map.is_paid:
		add_row_to_table(load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "PassedRow.tscn"), level_map)


func add_active_row_to_table(level_map: Dictionary) -> void:
	if level_map.is_active and level_map.is_paid and not level_map.is_passed:
		add_row_to_table(load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "ActiveRow.tscn"), level_map)


func add_pay_row_to_table(level_map: Dictionary) -> void:
	if not level_map.is_paid and not level_map.is_passed:
		add_row_to_table(load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "PayRow.tscn"), level_map)


func add_row_to_table(resource: Resource, level_map: Dictionary) -> void:
	var row: Node = resource.instance()
	row.set_current_level(level_map.level)
	table.add_child(row)
