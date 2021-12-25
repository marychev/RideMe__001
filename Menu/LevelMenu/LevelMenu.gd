extends BaseBikeMenu
class_name LevelMenu

var level_train = load("res://Game/Level/Level_Train/Level_Train.tscn").instance()
var level_0 = load("res://Game/Level/Level_0/Level_0.tscn").instance()
var level_1 = load("res://Game/Level/Level_1/Level_1.tscn").instance()

onready var btn_level_train: Node = $TextureRect/SliderContainer/Buttons/Train
onready var btn_level_0: Node = $TextureRect/SliderContainer/Buttons/Level_0
onready var btn_level_1: Node = $TextureRect/SliderContainer/Buttons/Level_1

const RES_LEVEL_PROGRESS_DIALOG_TSCN: String = "res://Menu/LevelMenu/LevelProgressDialog/LevelProgressDialog.tscn"
onready var progress_popup: Resource = preload(RES_LEVEL_PROGRESS_DIALOG_TSCN)


func _ready():
	._ready()

	btn_current_node.flat = bool(GameData.current_level != null)
	
	if GameData.current_level:
		init_slide(GameData.current_level)
		
		btn_level_0.flat = false
		btn_level_1.flat =  false
		
		btn_refit.modulate.a = 1
		btn_pay.modulate.a = 0.4


func init_slide(level: Node) -> void:
	.init_slide(level)
	set_menu_options(level)


func set_menu_options(level: Node) -> void:
	var level_text = "level: ....... %d" % [level.level]
	var track_text = "track: .......... %d" % [level.track]
	var price_text = "price: .................... %d" % [level.price]
	
	menu_options.get_node('LevelIssue').set_text(level.issue)
	menu_options.get_node('Level').set_text(level_text)
	menu_options.get_node('Track').set_text(track_text)
	menu_options.get_node('Price').set_text(price_text)


func set_title(level: Node) -> void:
	if GameData.current_level and GameData.current_level.title == level.title:
		title = GameData.current_level.title + "*"

	.set_title(level)



func _on_btn_pay_pressed() -> void:
	# check PlayerTracks
	# change state level
	# try to reload popup OR update 
	if not GameData.current_level:
		if selected_node:
			if PlayerData.rms < selected_node.price:
				field_log.error("Need to more Rms!")
			else:
				PlayerData.set_rms(PlayerData.rms - selected_node.price)
				
				GameData.current_level = selected_node
				
				var time = OS.get_datetime()
				print(time)
				
				btn_refit.modulate.a = 1
				btn_pay.modulate.a = 0.4

				btn_current_node.flat = true
				field_log.success("Level was paid success!")
		else:
			var message = "A level was not selected!"
			field_log.error(message)
	else:
		var message = "You have a level already!"
		field_log.info(message)
	
	if GameData.current_level:
		btn_level_0.flat = false
		btn_level_1.flat = false
		
		btn_level_0.disabled = true
		btn_level_1.disabled = true


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

	if not GameData.current_level:
		selected_node = level_train
		init_slide(selected_node)
	else:
		init_slide(GameData.current_level)


func _on_Train_pressed():
	field_log.clear()
	set_buttons_flat(btn_level_train)
	selected_node = level_train
	init_slide(selected_node)


func _on_Level_0_pressed():
	field_log.clear()
	set_buttons_flat(btn_level_0)
	selected_node = level_0
	init_slide(selected_node)


func set_buttons_flat(btn_active: Button) -> void:
	btn_current_node.flat = bool(btn_current_node.name == btn_active.name)
	btn_level_0.flat 	= bool(btn_level_0.name == btn_active.name)
	btn_level_1.flat = bool(btn_level_1.name == btn_active.name)
	btn_level_train.flat = bool(btn_level_train.name == btn_active.name)


