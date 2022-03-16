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


func set_player_bike(player_bike_data: Dictionary) -> void:
	if not player_bike_data.empty() and player_bike_data["bike_title"] != "Empty":
		max_speed = player_bike_data["max_speed"]
		max_height_jump = player_bike_data["max_height_jump"]
		max_power = player_bike_data["max_power"]


static func upgrade_bike_parameters(
	selected_rms: int,
	power_label: Label, power_added_rms: int,
	speed_label: Label,	speed_added_rms: int,
	jump_label: Label,	jump_added_rms: int
):
	PlayerData.save_rms(PlayerData.rms - selected_rms)

	var player_bike_cfg = PlayerData.player_bike_cfg
	
	PlayerData.player_bike.max_power += power_added_rms * 10
	set_param_value(power_label, PlayerData.player_bike.max_power)
	player_bike_cfg.set_max_power(PlayerData.player_bike.max_power)
	
	PlayerData.player_bike.max_speed += speed_added_rms * 10
	set_param_value(speed_label, PlayerData.player_bike.max_speed)
	player_bike_cfg.set_max_speed(PlayerData.player_bike.max_speed)
	
	PlayerData.player_bike.max_height_jump += jump_added_rms * 10
	set_param_value(jump_label, PlayerData.player_bike.max_height_jump)
	player_bike_cfg.set_max_height_jump(PlayerData.player_bike.max_height_jump)


static func set_param_value(label_value: Label, value: float) -> void:
	label_value.set_text(str(value))
	label_value.get("custom_fonts/font").set_outline_size(1)

