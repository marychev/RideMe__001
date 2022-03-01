extends MarginContainer
class_name FieldLog

const NAME: String = "FieldLog"

const WHITE = Color(1, 1, 1)
const GREEN = Color(0.1, 0.5, 0.1)
const RED = Color(0.8, 0, 0)
const FONT_PATH = "res://Game/GUI/assets/font/Comfortaa-Bold.ttf"

enum MODE {INFO, SUCCESS, ERROR}
	
var field_log: FieldLog
var target: Node
var position = Vector2.ZERO


"""func create() -> Label:	field_log = Label.new()	field_log.name = NAME	set_dynamic_font(field_log)	return field_log"""


func get_or_create() -> FieldLog:
	if not target:
		push_error("Need to init `target` of FieldLog's label")
		raise()
	
	field_log = target.get_parent().find_node(NAME)
	print(field_log)
	
	if not is_instance_valid(field_log):
		field_log = target.get_parent().find_node(NAME + "Success")
	elif not is_instance_valid(field_log):
		field_log = target.get_parent().find_node(NAME + "Error")

	return field_log


func clear() -> void:
	field_log = get_or_create()
	if is_instance_valid(field_log):
		target.remove_child(field_log)


"""
func display(message: String, mode: = MODE.INFO) -> void:
	field_log = get_or_create()

	field_log.set_text(message)
	field_log.set_position(position)
	field_log.set_scale(Vector2(2, 2))
	
	if mode == MODE.SUCCESS:
		field_log.modulate = GREEN
	elif mode == MODE.ERROR:
		field_log.modulate = RED
	else:
		field_log.modulate = WHITE

	target.add_child(field_log)
"""


func success(message: String):
	# display(message, MODE.SUCCESS)
	var field_log_instanse: FieldLog = load("res://components/field_log/FieldLogSuccess.tscn").instance()
	field_log_instanse.set_position(position)
	field_log_instanse.get_node("Label").set_text(message)
	target.add_child(field_log_instanse)

func error(message: String):
	var field_log_instanse: FieldLog = load("res://components/field_log/FieldLogError.tscn").instance()
	field_log_instanse.set_position(position)
	field_log_instanse.get_node("Label").set_text(message)
	target.add_child(field_log_instanse)
	
	# display(message, MODE.ERROR)

func info(message: String):
	# display(message, MODE.INFO)
	var field_log_instanse: FieldLog = load("res://components/field_log/FieldLog.tscn").instance()
	field_log_instanse.set_position(position)
	field_log_instanse.get_node("Label").set_text(message)
	target.add_child(field_log_instanse)


func set_dynamic_font(label: Label) -> void:
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load(FONT_PATH)
	dynamic_font.size = 24
	label.set("custom_fonts/font", dynamic_font)
