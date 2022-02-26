extends Node2D
class_name EmptyBike


# Keys
var title: String
var texture: Resource
var max_speed: float
var max_height_jump: float
var power: float
var max_power: float
var price: int

var bike_cfg: BikeCfg = load(PathData.BIKE_MODEL).new()


func _init(section: String = "Bike_Empty"):
	if bike_cfg.get_title(section):
		title = bike_cfg.get_title(section)
		texture = load(bike_cfg.get_texture(section))
		max_speed = bike_cfg.get_max_speed(section)
		max_height_jump = bike_cfg.get_max_height_jump(section)
		power = bike_cfg.get_power(section)
		max_power = bike_cfg.get_max_power(section)
		price = bike_cfg.get_price(section)


# -----------------
# TODO: !!!!!!!!!!!
# -----------------
static func upgrade_bike_parameters(
	selected_rms: int,
	power_value: Label, power_added_rms: int,
	speed_value: Label,	speed_added_rms: int,
	jump_value: Label,	jump_added_rms: int
):
	PlayerData.save_rms(PlayerData.rms - selected_rms)

	PlayerData.player_bike.max_power += power_added_rms
	set_param_value(power_value, PlayerData.player_bike.max_power)
	
	PlayerData.player_bike.max_speed += speed_added_rms
	set_param_value(speed_value, PlayerData.player_bike.max_speed)
	
	PlayerData.player_bike.max_height_jump += jump_added_rms
	set_param_value(jump_value, PlayerData.player_bike.max_height_jump)


static func set_param_value(label_value: Label, value: float) -> void:
	label_value.set_text(str(value))
	label_value.get("custom_fonts/font").set_outline_size(1)
