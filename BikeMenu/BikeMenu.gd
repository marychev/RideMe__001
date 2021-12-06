extends MarginContainer
class_name BikeMenu

onready var field_log: FieldLog = preload("res://Game/scripts/FieldLog.gd").new()

onready var empty_bike:EmptyBike = load("res://Game/Bike/EmptyBike.gd").new()
onready var sataur_bike:SataurBike = load("res://Game/Bike/SataurBike.gd").new()
onready var drawer_bike:DrawsterBike = load("res://Game/Bike/DrawsterBike.gd").new()

onready var menu_options = $TextureRect/SliderContainer/Detail/MenuOptions
onready var btn_refit: TouchScreenButton = $TextureRect/ButtonContainer/btn_refit

onready var bike_upgrade:Resource = preload("res://BikeMenu/BikeUpgradeDialog.tscn")

var selected_bike: Node


func _ready():
	$TextureRect/SliderContainer/Buttons/Current.flat = bool(PlayerData.player_bike != null)
	
	$TextureRect/RMCounter/Background/Value.set_text(str(PlayerData.rms))
	btn_refit.modulate.a = 0.6
	
	field_log.target = $TextureRect
	
	if PlayerData.player_bike:
		btn_refit.modulate.a = 1
		init_slide(PlayerData.player_bike)
		
		$TextureRect/SliderContainer/Buttons/Sataur.flat = bool(PlayerData.player_bike.title == "Sataur")
		$TextureRect/SliderContainer/Buttons/Drawster.flat = bool(PlayerData.player_bike.title == "Drawster")

func init_slide(bike: Node) -> void:
	selected_bike = bike
	set_title(bike)
	
	$TextureRect/SliderContainer/Detail/Image/Sprite.set_texture(bike.texture)	
	if PlayerData.player_bike or selected_bike.price > 0:
		$TextureRect/SliderContainer/Detail/Image/Sprite.show()
		$TextureRect/SliderContainer/Detail/Image/EmptySprite.hide()
	
	var power_text = "Max power: ....... %d" % [bike.max_power]
	var speed_text = "Max speed: ....... %d" % [bike.max_speed]
	var jump_text = "Max jump: .......... %d" % [bike.max_height_jump]
	var lives_text = "Lives: .................... %d" % [PlayerData.lives]
	var price_text = "Price: .................... %d" % [bike.price]
	
	menu_options.get_node('MaxPower').set_text(power_text)
	menu_options.get_node('MaxSpeed').set_text(speed_text)
	menu_options.get_node('MaxJump').set_text(jump_text)
	menu_options.get_node('Lives').set_text(lives_text)
	menu_options.get_node('Price').set_text(price_text)


func set_title(bike: Node) -> void:
	var title: String = bike.title if bike else "no"
	
	if PlayerData.player_bike: 
		if PlayerData.player_bike.title == bike.title:
			title = PlayerData.player_bike.title + "*"
	
	$TextureRect/Title.text = title


func _on_Sataur_pressed():
	field_log.clear()
	$TextureRect/SliderContainer/Buttons/Current.flat = bool(PlayerData.player_bike != null)
	$TextureRect/SliderContainer/Buttons/Sataur.flat = true
	$TextureRect/SliderContainer/Buttons/Drawster.flat = false
	
	$TextureRect/SliderContainer/Detail/Image/EmptySprite.hide()
	init_slide(sataur_bike)


func _on_Drawster_pressed():
	field_log.clear()
	$TextureRect/SliderContainer/Buttons/Drawster.flat = true
	$TextureRect/SliderContainer/Buttons/Sataur.flat = false
	$TextureRect/SliderContainer/Buttons/Current.flat = bool(PlayerData.player_bike != null)
	
	$TextureRect/SliderContainer/Detail/Image/EmptySprite.hide()
	init_slide(drawer_bike)


func _on_Current_pressed() -> void:
	field_log.clear()
	$TextureRect/SliderContainer/Buttons/Drawster.flat = false
	$TextureRect/SliderContainer/Buttons/Sataur.flat = false
	$TextureRect/SliderContainer/Buttons/Current.flat = bool(PlayerData.player_bike != null)
	
	if not PlayerData.player_bike:
		$TextureRect/SliderContainer/Detail/Image/Sprite.hide()

	init_slide(selected_bike)
	



func _on_Current_button_down() -> void:
	if not PlayerData.player_bike:
		$TextureRect/SliderContainer/Detail/Image/EmptySprite.show()
		selected_bike = empty_bike


func _on_btn_pay_pressed() -> void:
	if not PlayerData.player_bike:
		if selected_bike and selected_bike.price > 0:
			if PlayerData.rms < selected_bike.price:
				modulate.a = 0.2
				field_log.error("Need to more Rms!")
			else:
				modulate.a = 0.6

				PlayerData.set_rms(PlayerData.rms - selected_bike.price)
				PlayerData.player_bike = selected_bike
				
				btn_refit.modulate.a = 1

				$TextureRect/SliderContainer/Buttons/Current.flat = true
				field_log.success("Bike was paid success!")
		else:
			modulate.a = 0.2
			var message = "A bike was not selected!"
			field_log.error(message)
	else:
		modulate.a = 0.2
		var message = "You have a bike already!"
		field_log.info(message)
	
	if PlayerData.player_bike:
		$TextureRect/SliderContainer/Buttons/Sataur.flat = false
		$TextureRect/SliderContainer/Buttons/Drawster.flat = false
		$TextureRect/SliderContainer/Buttons/Sataur.disabled = true
		$TextureRect/SliderContainer/Buttons/Drawster.disabled = true


func _on_btn_pay_released() -> void:
	modulate.a = 1.0


func _on_btn_menu_pressed() -> void:
	var main_menu: String = "res://MainMenu/MainMenu.tscn"
	get_tree().change_scene(main_menu)


func _on_btn_refit_pressed() -> void:
	if PlayerData.player_bike:
		var bike_upgrade_instance: PopupDialog = bike_upgrade.instance()
		var bike_upgrade_name = bike_upgrade_instance.name # == "BikeUpgradeDialog"
		
		add_child(bike_upgrade_instance)
		yield(get_tree().create_timer(0.35), "timeout")
		
		if has_node(bike_upgrade_name) and get_node(bike_upgrade_name):
			bike_upgrade_instance.open(PlayerData.player_bike)		
	else:
		var message = "You have not a bike!"
		field_log.error(message)

"""
func _on_btn_refit_released() -> void:
	var bike_upgrade_instance: PopupDialog = bike_upgrade.instance()
	var bike_upgrade_name = bike_upgrade_instance.get_name() 	# name
	
	if has_node(bike_upgrade_name) and get_node(bike_upgrade_name):
		bike_upgrade_instance.free()
"""
