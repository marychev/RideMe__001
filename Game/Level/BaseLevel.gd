extends Node2D
class_name BaseLevel

const NUM_WIN: int = 5
const INIT_TIME_LEVEL: int = 20
var title: String = 'Collect the %s hourgrass!' % NUM_WIN
var texture = preload("res://Game/Level/assets/mountains-bottom.png")
var price: = 80
var has_win: bool = false

var issue: String = 'Collect the %s hourgrass!' % NUM_WIN
var level:int = 0
var track:int = 0


func are_you_win(hourgrass_count: int = PlayerData.time_level_count) -> bool:
	has_win = hourgrass_count == NUM_WIN
	return has_win
