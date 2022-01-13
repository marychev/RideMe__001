extends Node2D 
class_name Game

onready var player: Player = $Player
onready var RoadSet: Node2D = $RoadSet_0
onready var FirstRoadBody: StaticBody2D = RoadSet.get_node("RoadBody")
onready var Time: VBoxContainer = $GUI.get_node("Canvas/HBoxContainer/Time")


func _ready():
	var track = GameData.current_track
	add_child(track)
	# TODO: Add RoadSet_X related to Level_X
	PlayerData.reset_progress()


func _process(delta):
	Time.start(delta, player)
	FirstRoadBody.repeat_two_sprites()
