extends PopupDialog
class_name LevelProgressDialog

onready var field_log: FieldLog = preload("res://Game/scripts/FieldLog.gd").new()
onready var title: = "Progress"
onready var btn_no:TouchScreenButton  = $Nine/ButtonContainer/btn_no
onready var btn_yes:TouchScreenButton  = $Nine/ButtonContainer/btn_yes

onready var table = $Nine/TableContainer

var selected_rms: = 0


func _ready():
	field_log.target = $"."


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
		title += current_level.title
		
		find_node("Title").set_text(title)
		
# func set_rm_counter() -> void:	rm_counter.set_text(str(PlayerData.rms) + " / " + str(selected_rms))
