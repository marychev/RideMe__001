extends MarginContainer
class_name BikeMenu

onready var sataur_bike:SataurBike = load("res://Game/Bike/SataurBike.gd").new()
onready var drawer_bike:DrawerBike = load("res://Game/Bike/DrawerBike.gd").new()
onready var menu_options = $TextureRect/SliderContainer/Detail/MenuOptions

var selected_bike: Node


func _ready():
	$TextureRect/RMCounter/Background/Value.set_text(str(PlayerData.rms))

	if PlayerData.player_bike:
		init_slide(PlayerData.player_bike)


func init_slide(bike: Node) -> void:
	selected_bike = bike
	set_title(bike)
	
	$TextureRect/SliderContainer/Detail/Image/Sprite.set_texture(bike.texture)
	
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
	var title = bike.title + " / No bike"
	if PlayerData.player_bike:
		title = bike.title + " / " + PlayerData.player_bike.title + "*"
	$TextureRect/Title.text = title


func _on_Sataur_pressed():
	init_slide(sataur_bike)


func _on_Drawster_pressed():
	init_slide(drawer_bike)


func _on_btn_pay_pressed() -> void:
	if not PlayerData.player_bike:
		if  selected_bike:
			if PlayerData.rms < selected_bike.price:
				print("Need to more Rms!")
				modulate.a = 0.1
			else:
				print("Bike was paid success!")
				modulate.a = 0.6
				PlayerData.rms -= selected_bike.price
				PlayerData.player_bike = selected_bike
		else:
			print("A bike was not selected!")
			modulate.a = 0.1
			
	else:
		print("You have a bike already!")
		modulate.a = 0.1


func _on_btn_pay_released() -> void:
	modulate.a = 1.0


func _on_btn_menu_pressed() -> void:
	var main_menu: String = "res://MainMenu/MainMenu.tscn"
	get_tree().change_scene(main_menu)
