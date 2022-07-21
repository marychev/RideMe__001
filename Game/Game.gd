extends Node2D 
class_name Game

onready var player: Player = $Player
onready var Time: VBoxContainer = $GUI.get_node("Canvas/HBoxContainer/Time")


func _ready() -> void:
	var track = GameData.current_track
	add_child(track)
	PlayerData.reset_progress()


func _process(delta) -> void:
	Time.start(delta, player)
	# var FirstRoadBody: StaticBody2D = f_node("RoadBody")
	# FirstRoadBody.repeat_two_sprites()
	
