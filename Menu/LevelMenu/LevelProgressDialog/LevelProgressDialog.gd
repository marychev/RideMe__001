extends PopupDialog
class_name LevelProgressDialog

const RES_LEVEL_PROGRESS_DIALOG_ROWS: String = "res://Menu/LevelMenu/LevelProgressDialog/rows/"

# general
onready var field_log: FieldLog = preload("res://Game/scripts/FieldLog.gd").new()
onready var btn_no:TouchScreenButton  = $Nine/ButtonContainer/btn_no
onready var btn_yes:TouchScreenButton  = $Nine/ButtonContainer/btn_yes

onready var title: = "Progress %s"
onready var table: VBoxContainer = $Nine/TableContainer

var selected_rms: = 0


# general

func _ready():
	field_log.target = $"."
	
	for level in GameData.level_0_map:
		add_active_row_to_table(level)
		add_pay_row_to_table(level)


func _on_btn_no_pressed() -> void:
	btn_no.modulate.a = 0.1
	
	if is_visible(): 
		yield(get_tree().create_timer(0.4), "timeout")
		hide()


func _on_btn_yes_pressed():
	btn_yes.modulate.a = 0.1
		
	if is_visible(): 
		if PlayerData.rms < selected_rms:
			field_log.error("Need to more Rms!")
		
		yield(get_tree().create_timer(1.4), "timeout")
		get_tree().reload_current_scene()


func open(current_level: Node) -> void:
	popup()  # show()

	if current_level:
		title = title % [current_level.title]
		find_node("Title").set_text(title)


func add_passed_row_to_table(level_map: Dictionary) -> void:
	if level_map.is_passed and level_map.is_paid:
		add_row_to_table(
			load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "PassedRow.tscn"), level_map)


func add_active_row_to_table(level_map: Dictionary) -> void:
	if level_map.is_active and level_map.is_paid:
		add_row_to_table(
			load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "ActiveRow.tscn"), level_map)


func add_pay_row_to_table(level_map: Dictionary) -> void:
	if not level_map.is_paid:
		add_row_to_table(
			load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "PayRow.tscn"), level_map)



func add_row_to_table(resource: Resource, level_map: Dictionary) -> void:
	var row = resource.instance()
	row.set_current_level(level_map.level)
	table.add_child(row)
