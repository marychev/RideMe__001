extends Node2D
class_name BaseLevel

var num_win: int
var init_time_level: int
var price: int
var level:int 
var track:int 

var title: String
var texture
var issue: String

var has_win: bool


func _init():
	num_win = 10
	init_time_level = 100
	price = 0
	level = -1
	track = -1
	
	title = 'Training to mountains'
	issue = 'Collect the %s hourgrass!' % num_win
	texture = preload("res://Game/Level/assets/mountains.png")
	
	has_win = false



func are_you_win(hourgrass_count: int = PlayerData.time_level_count) -> bool:
	has_win = hourgrass_count == num_win
	return has_win
