extends EmptyBike
class_name SataurBike


func _init(section = "Bike_Sataur"):
	._init(section)


static func create_for_cfg() -> void:
	var texture = "res://Game/Bike/assets/I/sprites.png"
	var max_speed = 520.00
	var max_height_jump = 860.00
	var power = 300.00
	var max_power = 400.00
	var price: = 90
	GameData.bike_cfg.create("Sataur", texture, max_speed, max_height_jump, power, max_power, price)
