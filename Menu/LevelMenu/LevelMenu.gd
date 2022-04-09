extends BaseBikeMenu
class_name LevelMenu

# to top slider's buttons
var level_0: Level_0 = load(PathData.PATH_LEVEL_0).instance()
var level_1: Level_1 = load(PathData.PATH_LEVEL_1).instance()
var level_2: Level_2 = load(PathData.PATH_LEVEL_2).instance()

onready var btn_level_1: Button = $TextureRect/SliderContainer/Buttons/Level_1
onready var btn_level_2: Button = $TextureRect/SliderContainer/Buttons/Level_2

const RES_LEVEL_PROGRESS_DIALOG_TSCN: String = "res://Menu/LevelMenu/LevelProgressDialog/LevelProgressDialog.tscn"
onready var progress_popup: Resource = preload(RES_LEVEL_PROGRESS_DIALOG_TSCN)


func _ready():
	._ready()
	init_btn_current_node()
	
	btn_refit.connect("pressed", self, "_on_btn_refit_pressed")
	btn_pay.connect("pressed", self, "_on_btn_pay_pressed")
	
	if GameData.current_level or selected_node:
		btn_refit.modulate.a = 1
	
	btn_pay.modulate.a = 0.4
	if PlayerData.player_bike and GameData.current_track:
		btn_pay.modulate.a = 1
		btn_pay.type = "Run"
	
	if GameData.current_level and not is_instance_valid(GameData.current_track):
		_on_btn_refit_pressed()


func _on_btn_pay_pressed() -> void:
	var main_menu: MainMenu = load(PathData.RES_MAIN_MENU_TSCN).instance()  
	if not main_menu.can_start_play():
		main_menu.field_log = field_log
		main_menu.field_log_start_play()
	else:
		yield(get_tree().create_timer(0.4), "timeout")
		get_tree().change_scene(main_menu.game_tscn) 


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
	
	var level_id = 1
	var track_cfg: TrackCfg = load(PathData.TRACK_MODEL).new()
	
	GameData.current_level = level_1
	
	var _level_track: Dictionary = track_cfg.get_active_track(level_id)
	if not _level_track.empty():
		GameData.current_track = load(_level_track.resource).instance()
		selected_node = GameData.current_track
	else:
		selected_node = GameData.current_level
		
	init_slide(selected_node)


func set_menu_options(level: Level_0) -> void:
	if is_instance_valid(level):
		var level_text = "level: ....... %d" % [level.level_id]
		var track_text = "track: .......... %d" % [level.track_id]
		var price_text = "price: .................... %d" % [level.price]
		
		menu_options.get_node('LevelIssue').set_text(level.issue)
		menu_options.get_node('Level').set_text(level_text)
		menu_options.get_node('Track').set_text(track_text)
		menu_options.get_node('Price').set_text(price_text)


func set_buttons_flat(btn_active: Button) -> void:
	btn_current_node.flat = bool(btn_current_node.name == btn_active.name)
	btn_level_1.flat = bool(btn_level_1.name == btn_active.name)
	btn_level_2.flat = bool(btn_level_2.name == btn_active.name)


func init_slide(level: Node2D) -> void:
	.init_slide(level)
	set_menu_options(level)
	btn_refit.modulate.a = 1


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
