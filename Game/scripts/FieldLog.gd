extends Node
class_name FieldLog

const NAME: String = "FieldLog"

const WHITE = Color(1, 1, 1)
const GREEN = Color(0.1, 0.5, 0.1)
const RED = Color(0.8, 0, 0)
const FONT_PATH = "res://Game/GUI/assets/font/Comfortaa-Bold.ttf"

enum MODE {INFO, SUCCESS, ERROR}
	
var field_log: Label
var target: Node
var position = Vector2(20, 10)


func create() -> Label:
	field_log = Label.new()
	field_log.name = NAME
	set_dynamic_font(field_log)
	
	return field_log


func get_or_create() -> Label:
	if not target:
		push_error("Need to init `target` of FieldLog's label")
		raise()

	field_log = target.get_node(NAME)
	if not is_instance_valid(field_log):
		field_log = create()
		
	return field_log


func clear() -> void:
	field_log = get_or_create()
	if is_instance_valid(field_log):
		target.remove_child(field_log)


func show(message: String, mode: = MODE.INFO) -> void:
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


func success(message: String):
	show(message, MODE.SUCCESS)

func error(message: String):
	show(message, MODE.ERROR)

func info(message: String):
	show(message, MODE.INFO)


func set_dynamic_font(label: Label) -> void:
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load(FONT_PATH)
	dynamic_font.size = 24
	label.set("custom_fonts/font", dynamic_font)
