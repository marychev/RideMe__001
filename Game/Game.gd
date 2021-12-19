extends Node2D 
class_name Game

onready var player: KinematicBody2D = $Player
onready var RoadSet: Node2D = $RoadSet_0
onready var FirstRoadBody: StaticBody2D = RoadSet.get_node("RoadBody")
onready var Time: VBoxContainer = $GUI.get_node("Canvas/HBoxContainer/Time")


func _ready():
	add_child(player.current_level)
	# TODO: Add RoadSet_X related to Level_X
	PlayerData.reset_progress()


func _process(delta):
	Time.start(delta, player)
	FirstRoadBody.repeat_two_sprites()
