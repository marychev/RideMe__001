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
	btn_current_node.flat = not GameData.current_level.empty()
	
	btn_refit.connect("pressed", self, "_on_btn_refit_pressed")
	btn_pay.connect("pressed", self, "_on_btn_pay_pressed")
	
	if selected_node != null:
		btn_refit.modulate.a = 1
	
	btn_pay.modulate.a = 0.4
	if PlayerData.player_bike and GameData.current_track and not GameData.current_level.empty():
		btn_pay.modulate.a = 1
		btn_pay.type = "Run"
		btn_pay.anim_flicker()
	
	if not is_instance_valid(GameData.current_track):
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
		selected_node = GameData.current_track
	else:
		selected_node = level_0
		
	init_slide(selected_node)


func _on_Level_1_pressed():
	field_log.clear()
	set_buttons_flat(btn_level_1)
	
	var level_id = 1
	var level_cfg: LevelCfg = load(PathData.LEVEL_MODEL).new()
	var track_cfg: TrackCfg = load(PathData.TRACK_MODEL).new()
	
	var level_section = level_cfg.get_section(level_id)
	var track: Dictionary = track_cfg.get_active_track(level_id)
	if not track.empty():
		GameData.current_track = load(track.resource).instance()
		GameData.current_level = level_cfg.as_dict(level_section)
		
		if PlayerData.player_bike:
			btn_pay.modulate.a = 1
			btn_pay.anim_flicker()

	selected_node = GameData.current_track
	init_slide(selected_node)


func init_btn_current_node() -> void:
	btn_current_node.flat = false
	btn_current_node.disabled = true

	if not GameData.current_level.empty() and GameData.current_track:
		init_slide(GameData.current_track)
		btn_level_1.flat = false
		btn_level_2.flat =  false
		

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


func init_slide(track: Node2D) -> void:
	if track:
		.init_slide(track)
		set_menu_options(track)
		btn_refit.modulate.a = 1
		$Completed.visible = GameData.track_cfg.has_passed_level(track.level_id)
	


