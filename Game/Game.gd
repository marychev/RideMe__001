extends Node2D 
class_name Game

onready var Player: KinematicBody2D = $Player
onready var RoadSet: Node2D = $RoadSet
onready var FirstRoadBody: StaticBody2D = RoadSet.get_node("RoadBody")
onready var Level_I: Node2D  = $Level_1
onready var Level_I_J: Node = Level_I.get_node("Level_1_0")
onready var GUI: MarginContainer = $GUI
onready var Time: VBoxContainer = GUI.get_node("Canvas/HBoxContainer/Time")


func _ready():
	force_init_objects_to('RoadBody', Player, RoadSet)
	Player.force_init(GUI)
	force_init_objects_to('RM', GUI, Level_I_J)


func _process(delta):
	Time.start(delta, Player)
	FirstRoadBody.repeat_two_sprites()


func force_init_objects_to(name, scene, tree):
	for i in tree.get_child_count():
		if name.to_upper() in tree.get_child(i).name.to_upper():
			if tree.get_child(i).has_method('__force_init__'):
				tree.get_child(i).__force_init__(scene)

