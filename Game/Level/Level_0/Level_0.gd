extends BaseLevel
class_name Level_0


func _init():
	num_win = 5
	init_time_level = 20
	title = 'Mountains'
	texture = preload("res://Game/Level/assets/mountains-bottom.png")
	issue = 'Collect the %s hourgrass!' % num_win
	price = 10
	level = 0
	track = 0
