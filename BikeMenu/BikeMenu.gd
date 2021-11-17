extends MarginContainer
class_name BikeMenu

onready var sataur_bike:SataurBike = load("res://Game/Bike/SataurBike.gd").new()
onready var drawer_bike:DrawerBike = load("res://Game/Bike/DrawerBike.gd").new()

onready var menu_options = $TextureRect/SliderContainer/Detail/MenuOptions

func _ready():
	$TextureRect/RMCounter/Background/Value.set_text(str(PlayerData.rms))
	
	var player_bike = sataur_bike
	init_slide(player_bike)


func init_slide(bike: Node) -> void:
	$TextureRect/Title.text = bike.title
	$TextureRect/SliderContainer/Detail/Image/Sprite.set_texture(bike.texture)
	
	var power_text = "Max power: ....... %d" % [bike.max_power]
	var speed_text = "Max speed: ....... %d" % [bike.max_speed]
	var jump_text = "Max jump: .......... %d" % [bike.max_height_jump]
	var lives_text = "Lives: .................... %d" % [PlayerData.lives]
	menu_options.get_node('MaxPower').set_text(power_text)
	menu_options.get_node('MaxSpeed').set_text(speed_text)
	menu_options.get_node('MaxJump').set_text(jump_text)
	menu_options.get_node('Lives').set_text(lives_text)


func _on_Sataur_pressed():
	init_slide(sataur_bike)


func _on_Drawster_pressed():
	init_slide(drawer_bike)
