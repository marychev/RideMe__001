extends BaseBikeMenu
class_name LevelMenu

onready var btn_level_0: Node = $TextureRect/SliderContainer/Buttons/Level_0
onready var btn_level_1: Node = $TextureRect/SliderContainer/Buttons/Level_1


func _ready():
	._ready()

	btn_current_node.flat = bool(GameData.current_level != null)
	
	if GameData.current_level:
		btn_refit.modulate.a = 1
		init_slide(GameData.current_level)
		
		btn_level_0.flat = true
		btn_level_1.flat =  true
		
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


func set_title(level: Node, title="no") -> void:
	if GameData.current_level and GameData.current_level.title == level.title:
		title = GameData.current_level.title + "*"

	.set_title(level, title)


func _on_Current_pressed() -> void:
	._on_Current_pressed()
	btn_level_0.flat = false
	btn_level_1.flat = false
	
	if not GameData.current_level:
		init_slide(selected_node)
	else:
		init_slide(GameData.current_level)


func _on_btn_pay_pressed() -> void:
	if not GameData.current_level:
		if selected_node and selected_node.price > 0:
			if PlayerData.rms < selected_node.price:
				field_log.error("Need to more Rms!")
			else:
				PlayerData.set_rms(PlayerData.rms - selected_node.price)
				GameData.current_level = selected_node
				
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
	pass


func _on_Level_0_pressed():
	pass # Replace with function body.
