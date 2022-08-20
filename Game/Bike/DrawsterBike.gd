extends EmptyBike
class_name DrawsterBike


func _init(section: String = "Bike_Drawster"):
	._init(section)


static func create_for_cfg() -> void:
	var texture = "res://Game/Bike/assets/II/sprites.png"
	var max_speed = 600.00
	var max_height_jump = 865.00
	var power = 300.00
	var max_power = 410.00
	var price: = 90
	var bike_cfg: BikeCfg = load(PathData.BIKE_MODEL).new()
	var res := bike_cfg.create("Drawster", texture, max_speed, max_height_jump, power, max_power, price)
	if res != OK:
		printerr("ERROR: DrawsterBike create_for_cfg")
