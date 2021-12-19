extends Node2D

const NUM_WIN: int = 10
const INIT_TIME_LEVEL: int = 50
var title: String = 'Collect the %s hourgrass!' % NUM_WIN

var has_win: bool = false


func are_you_win(hourgrass_count: int = PlayerData.time_level_count) -> bool:
	has_win = hourgrass_count == NUM_WIN
	return has_win
