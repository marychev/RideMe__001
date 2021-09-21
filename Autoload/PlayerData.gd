extends Node

signal score_updated
signal lives_updated

var score: = 0 setget set_score
var lives: = 2 setget set_lives

func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")


func set_lives(value: int) -> void:
	lives = value
	emit_signal("lives_updated")
