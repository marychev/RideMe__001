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


func _init(section: String = "Bike_Empty"):
	if GameData.bike_cfg.get_title(section):
		title = GameData.bike_cfg.get_title(section)
		texture = load(GameData.bike_cfg.get_texture(section))
		max_speed = GameData.bike_cfg.get_max_speed(section)
		max_height_jump = GameData.bike_cfg.get_max_height_jump(section)
		power = GameData.bike_cfg.get_power(section)
		max_power = GameData.bike_cfg.get_max_power(section)
		price = GameData.bike_cfg.get_price(section)


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
	
	PlayerData.player_bike.max_power += power_added_rms
	set_param_value(power_label, PlayerData.player_bike.max_power)
	player_bike_cfg.set_max_power(PlayerData.player_bike.max_power)
	
	PlayerData.player_bike.max_speed += speed_added_rms
	set_param_value(speed_label, PlayerData.player_bike.max_speed)
	player_bike_cfg.set_max_speed(PlayerData.player_bike.max_speed)
	
	PlayerData.player_bike.max_height_jump += jump_added_rms
	set_param_value(jump_label, PlayerData.player_bike.max_height_jump)
	player_bike_cfg.set_max_height_jump(PlayerData.player_bike.max_height_jump)


static func set_param_value(label_value: Label, value: float) -> void:
	label_value.set_text(str(value))
	label_value.get("custom_fonts/font").set_outline_size(1)
	


static func create_for_cfg() -> void:
	var texture: ="res://Game/Bike/assets/I/animation/collision.png"
	var max_speed = 0.00
	var max_height_jump = 0.00
	var power = 0.00
	var max_power = 0.00
	var price: = 0
	GameData.bike_cfg.create("Empty", texture, max_speed, max_height_jump, power, max_power, price)
