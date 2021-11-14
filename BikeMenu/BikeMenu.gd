extends MarginContainer
class_name BikeMenu

onready var sataur_bike:SataurBike = load("res://Game/Bike/SataurBike.gd").new()


func _ready():
	$TextureRect/Title.text = sataur_bike.title
	
	var power_text = "Max power: ....... %d" % [sataur_bike.max_power]
	var speed_text = "Max speed: ....... %d" % [sataur_bike.max_speed]
	var jump_text = "Max jump: .......... %d" % [sataur_bike.max_height_jump]
	var lives_text = "Lives: .................... %d" % [PlayerData.lives]
	$TextureRect/HBoxContainer/MenuOptions/MaxPower.set_text(power_text)
	$TextureRect/HBoxContainer/MenuOptions/MaxSpeed.set_text(speed_text)
	$TextureRect/HBoxContainer/MenuOptions/MaxJump.set_text(jump_text)
	$TextureRect/HBoxContainer/MenuOptions/Lives.set_text(lives_text)
	
	$TextureRect/RMCounter/Background/Value.set_text(str(PlayerData.rms))

