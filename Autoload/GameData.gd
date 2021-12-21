extends Node

var current_level: BaseLevel


var level_0_map: Array = [
	{
		"level": load("res://Game/Level/Level_Train/Level_Train.tscn").instance(),
		"is_paid": true,
		"is_active": true,
		"is_fail": false,
		"is_passed": true
	},
	{
		"level": load("res://Game/Level/Level_0/Level_0.tscn").instance(),
		"is_paid": true,
		"is_active": true,
		"is_fail": false,
		"is_passed": false
	},
	{
		"level": load("res://Game/Level/Level_1/Level_1.tscn").instance(),
		"is_paid": false,
		"is_active": false,
		"is_fail": false,
		"is_passed": false
	}
]
