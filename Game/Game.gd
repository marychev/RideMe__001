extends Node2D 
class_name Game

onready var Player: KinematicBody2D = $Player
onready var RoadSet: Node2D = $RoadSet
onready var FirstRoadBody: StaticBody2D = RoadSet.get_node("RoadBody")

onready var GUI: MarginContainer = $GUI
onready var Time: VBoxContainer = GUI.get_node("Canvas/HBoxContainer/Time")


func _ready():
	PlayerData.reset_progress()


func _process(delta):
	Time.start(delta, Player)
	FirstRoadBody.repeat_two_sprites()
