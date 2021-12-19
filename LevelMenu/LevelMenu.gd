extends MarginContainer
class_name LevelMenu

var path_data: PathData = preload("res://Autoload/PathData.gd").new()
var selected_level: Node

onready var field_log: FieldLog = preload("res://Game/scripts/FieldLog.gd").new()
"""
onready var empty_bike:EmptyBike = load("res://Game/Bike/EmptyBike.gd").new()
onready var sataur_bike:SataurBike = load("res://Game/Bike/SataurBike.gd").new()
onready var drawer_bike:DrawsterBike = load("res://Game/Bike/DrawsterBike.gd").new()
"""
onready var menu_options = $TextureRect/SliderContainer/Detail/MenuOptions
onready var btn_refit: TextureButton = $TextureRect/ButtonContainer/btn_refit
onready var btn_pay: TextureButton = $TextureRect/ButtonContainer/btn_pay

onready var btn_level_0: Node = $TextureRect/SliderContainer/Buttons/Level_0
onready var btn_level_1: Node = $TextureRect/SliderContainer/Buttons/Level_1
onready var btn_current_level: Node = $TextureRect/SliderContainer/Buttons/Current

# onready var level_issue: Node = $TextureRect/SliderContainer/Detail/MenuOptions/LevelIssue

"""
onready var bike_upgrade:Resource = preload("res://BikeMenu/BikeUpgradeDialog.tscn")
var selected_bike: Node
"""



func _ready():
	btn_current_level.flat = bool(GameData.current_level != null)
	
	$TextureRect/RMCounter/Background/Value.set_text(str(PlayerData.rms))
	btn_refit.modulate.a = 0.4
	
	field_log.target = $TextureRect
	
	if GameData.current_level:
		btn_refit.modulate.a = 1
		init_slide(GameData.current_level)
		
		btn_level_0.flat = true  # bool(PlayerData.player_bike.title == "Sataur")
		btn_level_1.flat =  true # bool(PlayerData.player_bike.title == "Drawster")
		
		btn_pay.modulate.a = 0.4


func init_slide(level: Node) -> void:
	selected_level = level
	set_title(level)
	
	$TextureRect/SliderContainer/Detail/Image/Sprite.set_texture(level.texture)	
	"""
	if GameData.current_level or selected_level.price > 0:
		$TextureRect/SliderContainer/Detail/Image/Sprite.show()
		$TextureRect/SliderContainer/Detail/Image/EmptySprite.hide()
	"""
	
	var level_text = "level: ....... %d" % [level.level]
	var track_text = "track: .......... %d" % [level.track]
	var price_text = "price: .................... %d" % [level.price]
	
	menu_options.get_node('LevelIssue').set_text(level.issue)
	menu_options.get_node('Level').set_text(level_text)
	menu_options.get_node('Track').set_text(track_text)
	menu_options.get_node('Price').set_text(price_text)


func set_title(level: Node) -> void:
	var title: String = level.title if level else "no"
	
	if GameData.current_level: 
		if GameData.current_level.title == level.title:
			title = GameData.current_level.title + "*"
	
	$TextureRect/Title.text = title

"""
func _on_Sataur_pressed():
	field_log.clear()
	$TextureRect/SliderContainer/Buttons/Current.flat = false
	$TextureRect/SliderContainer/Buttons/Sataur.flat = true
	$TextureRect/SliderContainer/Buttons/Drawster.flat = false
	
	$TextureRect/SliderContainer/Detail/Image/EmptySprite.hide()
	init_slide(sataur_bike)

func _on_Drawster_pressed():
	field_log.clear()
	$TextureRect/SliderContainer/Buttons/Drawster.flat = true
	$TextureRect/SliderContainer/Buttons/Sataur.flat = false
	$TextureRect/SliderContainer/Buttons/Current.flat = false
	
	$TextureRect/SliderContainer/Detail/Image/EmptySprite.hide()
	init_slide(drawer_bike)
"""

func _on_Current_pressed() -> void:
	field_log.clear()
	btn_level_0.flat = false
	btn_level_1.flat = false
	btn_current_level.flat = true
	
	if not GameData.current_level:
		# $TextureRect/SliderContainer/Detail/Image/Sprite.hide()
		init_slide(selected_level)
	else:
		init_slide(GameData.current_level)


func _on_Current_button_down() -> void:
	if not GameData.current_level:
		# $TextureRect/SliderContainer/Detail/Image/EmptySprite.show()
		# selected_level = empty_bike
		pass


func _on_btn_pay_pressed() -> void:
	if not GameData.current_level:
		if selected_level and selected_level.price > 0:
			if PlayerData.rms < selected_level.price:
				field_log.error("Need to more Rms!")
			else:
				PlayerData.set_rms(PlayerData.rms - selected_level.price)
				GameData.current_level = selected_level
				
				btn_refit.modulate.a = 1
				btn_pay.modulate.a = 0.4

				btn_current_level.flat = true
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



func _on_btn_menu_pressed() -> void:
	var main_menu: String = path_data.RES_MAIN_MENU_TSCN
	get_tree().change_scene(main_menu)


func _on_btn_refit_pressed() -> void:
	pass


func _on_Level_0_pressed():
	pass # Replace with function body.
