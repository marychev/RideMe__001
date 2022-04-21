extends EmptyBike
class_name DrawsterBike


func _init(section: String = "Bike_Drawster"):
	._init(section)


static func create_for_cfg() -> void:
	var texture = "res://Game/Bike/assets/II/sprites.png"
	var max_speed = 500.00
	var max_height_jump = 865.00
	var power = 300.00
	var max_power = 410.00
	var price: = 90
	GameData.bike_cfg.create("Sataur", texture, max_speed, max_height_jump, power, max_power, price)
