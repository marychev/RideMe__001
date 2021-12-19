extends BaseBikeMenu
class_name BikeMenu

onready var empty_bike:EmptyBike = load("res://Game/Bike/EmptyBike.gd").new()
onready var sataur_bike:SataurBike = load("res://Game/Bike/SataurBike.gd").new()
onready var drawer_bike:DrawsterBike = load("res://Game/Bike/DrawsterBike.gd").new()

onready var bike_upgrade: Resource = preload("res://Menu/BikeMenu/BikeUpgradeDialog.tscn")


func _ready():
	._ready()
	
	btn_current_node.flat = bool(PlayerData.player_bike != null)
		
	if PlayerData.player_bike:
		btn_refit.modulate.a = 1
		init_slide(PlayerData.player_bike)
		
		$TextureRect/SliderContainer/Buttons/Sataur.flat = bool(PlayerData.player_bike.title == "Sataur")
		$TextureRect/SliderContainer/Buttons/Drawster.flat = bool(PlayerData.player_bike.title == "Drawster")
		
		btn_pay.modulate.a = 0.4


func init_slide(bike: Node) -> void:
	.init_slide(bike)
	set_menu_options(bike)

	
func set_title(bike: Node, title = "") -> void:
	if PlayerData.player_bike and PlayerData.player_bike.title == bike.title:
		title = PlayerData.player_bike.title + "*"

	.set_title(bike, title)


func set_menu_options(bike: Node):
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


func _on_Sataur_pressed():
	field_log.clear()
	btn_current_node.flat = false
	$TextureRect/SliderContainer/Buttons/Sataur.flat = true
	$TextureRect/SliderContainer/Buttons/Drawster.flat = false
	
	init_slide(sataur_bike)


func _on_Drawster_pressed():
	field_log.clear()
	btn_current_node.flat = false
	$TextureRect/SliderContainer/Buttons/Drawster.flat = true
	$TextureRect/SliderContainer/Buttons/Sataur.flat = false
	
	init_slide(drawer_bike)


func _on_Current_pressed() -> void:
	._on_Current_pressed()
	
	$TextureRect/SliderContainer/Buttons/Drawster.flat = false
	$TextureRect/SliderContainer/Buttons/Sataur.flat = false
	
	if not PlayerData.player_bike:
		init_slide(selected_node)
	else:
		init_slide(PlayerData.player_bike)


func _on_Current_button_down() -> void:
	if not PlayerData.player_bike:
		selected_node = empty_bike


func _on_btn_pay_pressed() -> void:
	if not PlayerData.player_bike:
		if selected_node and selected_node.price > 0:
			if PlayerData.rms < selected_node.price:
				field_log.error("Need to more Rms!")
			else:
				PlayerData.set_rms(PlayerData.rms - selected_node.price)
				PlayerData.player_bike = selected_node
				
				btn_refit.modulate.a = 1
				btn_pay.modulate.a = 0.4

				$TextureRect/SliderContainer/Buttons/Current.flat = true
				field_log.success("Bike was paid success!")
		else:
			var message = "A bike was not selected!"
			field_log.error(message)
	else:
		var message = "You have a bike already!"
		field_log.info(message)
	
	if PlayerData.player_bike:
		$TextureRect/SliderContainer/Buttons/Sataur.flat = false
		$TextureRect/SliderContainer/Buttons/Drawster.flat = false
		$TextureRect/SliderContainer/Buttons/Sataur.disabled = true
		$TextureRect/SliderContainer/Buttons/Drawster.disabled = true


func _on_btn_refit_pressed() -> void:
	if PlayerData.player_bike:
		var bike_upgrade_instance: PopupDialog = bike_upgrade.instance()
		var bike_upgrade_name = bike_upgrade_instance.name # == "BikeUpgradeDialog"
		
		add_child(bike_upgrade_instance)
		yield(get_tree().create_timer(0.4), "timeout")
		
		if has_node(bike_upgrade_name) and get_node(bike_upgrade_name):
			bike_upgrade_instance.open(PlayerData.player_bike)		
	else:
		var message = "You have not a bike!"
		field_log.error(message)
