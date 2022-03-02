extends PopupDialog
class_name BaseProgressDialog

onready var field_log: FieldLog = preload("res://components/field_log/FieldLog.gd").new()
onready var title: String = "<Popup dialog: %s>"
onready var btn_no:TouchScreenButton  = $Nine/ButtonContainer/btn_no
onready var btn_yes:TouchScreenButton  = $Nine/ButtonContainer/btn_yes


func _ready():
	field_log.target = $"."


# buttons' singans 

func _on_btn_no_pressed() -> void:
	btn_no.modulate.a = 0.1
	
	if is_visible(): 
		yield(get_tree().create_timer(0.4), "timeout")
		hide()


func _on_btn_yes_pressed():
	GameData._ready()
	btn_yes.modulate.a = 0.1
		
	if is_visible(): 
		yield(get_tree().create_timer(0.4), "timeout")
		get_tree().reload_current_scene()


# popup

func open(current_node: Node) -> void:
	popup()  # show()
	set_title(current_node)


# setters

func set_title(current_node: Node) -> void:
	if current_node:
		title = title % [current_node.title]
		$Nine/Title.set_text(title)

