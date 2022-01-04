extends BaseBikeMenu
class_name LevelMenu

# to top slider's buttons
var level_0: Level_0 = load(PathData.PATH_LEVEL_0).instance()
var level_1: Level_1 = load(PathData.PATH_LEVEL_1).instance()
var level_2: Level_2 = load(PathData.PATH_LEVEL_2).instance()

# onready var btn_level_0: Button = $TextureRect/SliderContainer/Buttons/Level_0
onready var btn_level_1: Button = $TextureRect/SliderContainer/Buttons/Level_1
onready var btn_level_2: Button = $TextureRect/SliderContainer/Buttons/Level_2

const RES_LEVEL_PROGRESS_DIALOG_TSCN: String = "res://Menu/LevelMenu/LevelProgressDialog/LevelProgressDialog.tscn"
onready var progress_popup: Resource = preload(RES_LEVEL_PROGRESS_DIALOG_TSCN)


func _ready():
	._ready()
	init_btn_current_node()
	
	btn_refit.connect("pressed", self, "_on_btn_refit_pressed")
	btn_pay.connect("pressed", self, "_on_btn_pay_pressed")


func init_slide(level: Node2D) -> void:
	.init_slide(level)
	set_menu_options(level)


func set_menu_options(level: Level_0) -> void:
	var level_text = "level: ....... %d" % [level.level_id]
	var track_text = "track: .......... %d" % [level.track_id]
	var price_text = "price: .................... %d" % [level.price]
	
	menu_options.get_node('LevelIssue').set_text(level.issue)
	menu_options.get_node('Level').set_text(level_text)
	menu_options.get_node('Track').set_text(track_text)
	menu_options.get_node('Price').set_text(price_text)


func _on_btn_pay_pressed() -> void:
	if not GameData.current_level:
		if selected_node:
			# TODO:
			
			if PlayerData.rms < selected_node.price:
				field_log.error("Need to more Rms!")
			else:
				PlayerData.set_rms(PlayerData.rms - selected_node.price)

				GameData.current_level = selected_node

				btn_refit.modulate.a = 1
				btn_pay.modulate.a = 0.4

				btn_current_node.flat = true
				field_log.success("Level's track has been initiated successfully!")
		else:
			var message = "A level was not selected!"
			field_log.error(message)
	else:
		var message = "You have a level already!"
		field_log.info(message)
	
	if GameData.current_level:
		btn_level_1.flat = false
		btn_level_2.flat = false
		
		btn_level_1.disabled = true
		btn_level_2.disabled = true


func _on_btn_refit_pressed() -> void:
	if GameData.current_level:
		var progress_popup_instance: PopupDialog = progress_popup.instance()
		var progress_popup_name = progress_popup_instance.name
		
		add_child(progress_popup_instance)
		yield(get_tree().create_timer(0.4), "timeout")
		
		if has_node(progress_popup_name) and get_node(progress_popup_name):
			progress_popup_instance.open(GameData.current_level)
	else:
		var message = "You have not a level!"
		field_log.error(message)


func _on_Current_pressed() -> void:
	._on_Current_pressed()
	
	set_buttons_flat(btn_current_node)
	
	if GameData.current_track:
		init_slide(GameData.current_track)
	elif GameData.current_level:
		init_slide(GameData.current_level)
	else:
		selected_node = level_0
		init_slide(selected_node)


func _on_Level_1_pressed():
	field_log.clear()
	set_buttons_flat(btn_level_1)
	selected_node = level_1
	init_slide(selected_node)


func set_buttons_flat(btn_active: Button) -> void:
	btn_current_node.flat = bool(btn_current_node.name == btn_active.name)
	btn_level_1.flat = bool(btn_level_1.name == btn_active.name)
	btn_level_2.flat = bool(btn_level_2.name == btn_active.name)


func init_btn_current_node() -> void:
	btn_current_node.flat = false
	btn_current_node.disabled = true

	if GameData.current_level:
		if GameData.current_track:
			init_slide(GameData.current_track)
		else:
			init_slide(GameData.current_level)
		
		btn_level_1.flat = false
		btn_level_2.flat =  false
		
		btn_refit.modulate.a = 1
		btn_pay.modulate.a = 0.4
