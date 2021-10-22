extends Node2D
class_name BaseLevel

const NUM_WIN: int = 1 # +1
var title: String = 'Collect 5 hourgrass'
var has_win: bool = false


func are_you_win(hourgrass_count: int = PlayerData.time_level_count) -> bool:
	has_win = hourgrass_count == NUM_WIN
	return has_win
