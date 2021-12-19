extends Node
class_name EmptyBike

var title = "No bike"
var texture = preload("res://Game/Bike/assets/I/collision.png")
var max_speed: = 0.00
var max_height_jump: = 0.00
var power: = 0.00
var max_power: = 0.00
var price: = 0


static func upgrade_bike_parameters(
	selected_rms: int,
	power_value: Label, power_added_rms: int,
	speed_value: Label,	speed_added_rms: int,
	jump_value: Label,	jump_added_rms: int
):
	PlayerData.set_rms(PlayerData.rms - selected_rms)

	PlayerData.player_bike.max_power += power_added_rms
	set_param_value(power_value, PlayerData.player_bike.max_power)
	
	PlayerData.player_bike.max_speed += speed_added_rms
	set_param_value(speed_value, PlayerData.player_bike.max_speed)
	
	PlayerData.player_bike.max_height_jump += jump_added_rms
	set_param_value(jump_value, PlayerData.player_bike.max_height_jump)


static func set_param_value(label_value: Label, value: float) -> void:
	label_value.set_text(str(value))
	label_value.get("custom_fonts/font").set_outline_size(1)
