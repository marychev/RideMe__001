extends BaseProgressDialog
class_name LevelProgressDialog

const RES_LEVEL_PROGRESS_DIALOG_ROWS = "res://Menu/LevelMenu/LevelProgressDialog/rows/"

onready var table: VBoxContainer = $Nine/TableContainer


func _ready():
	._ready()
	
	set_title(GameData.current_track)
	
	clean_table()
	fill_table()


func _on_btn_yes_pressed():
	._on_btn_yes_pressed()
	
	if has_node("/root/LevelMenu") and not GameData.current_level.empty() and GameData.current_track:
		get_node("/root/LevelMenu").selected_node = GameData.current_track
		set_title(GameData.current_track)
	
# work on table

func clean_table() -> void:
	if is_instance_valid(table) and table.get_child_count() > 0:
		for row in table.get_children():
			table.remove_child(row)
			row.queue_free()


func fill_table() -> void:
	var track_cfg: TrackCfg = load(PathData.TRACK_MODEL).new()
	
	for track in track_cfg.get_tracks(GameData.current_level.id):
		if LevelTrackStates.PASSED == track.state:
			add_passed_row_to_table(track)
		elif LevelTrackStates.FAIL == track.state:
			add_fail_row_to_table(track)
		elif LevelTrackStates.ACTIVE == track.state:
			add_active_row_to_table(track)
		elif LevelTrackStates.PAY == track.state:
			add_pay_row_to_table(track)


func add_passed_row_to_table(track: Dictionary) -> void:
	add_row_to_table(load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "PassedRow.tscn"), track)


func add_active_row_to_table(track: Dictionary) -> void:
	add_row_to_table(load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "ActiveRow.tscn"), track)


func add_pay_row_to_table(track: Dictionary) -> void:
	add_row_to_table(load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "PayRow.tscn"), track)


func add_fail_row_to_table(track: Dictionary) -> void:
	add_row_to_table(load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "FailRow.tscn"), track)
	

func add_row_to_table(resource: Resource, track: Dictionary) -> void:
	if is_instance_valid(table):
		var row: ActiveRow = resource.instance()
		row.init_track(track)
		table.add_child(row)
