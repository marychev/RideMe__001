extends BaseLevel
class_name Level_1


func _init():
	num_win = 20
	init_time_level = 40
	title = 'Mountains'
	issue = 'Collect the %s hourgrass!' % num_win
	texture = preload("res://Game/Level/assets/mountains-bottom.png")
	price = 40
	level = 0
	track = 1

