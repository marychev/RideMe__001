extends Level_0
class_name Level2_0

onready var _custom_background: Resource = load("res://Game/Level2/Background/Background.tscn")
onready var custom_background: ParallaxBackground = _custom_background.instance()
onready var root := get_parent()
onready var bd: ParallaxBackground = root.get_node("Background")


func _init() -> void:
	ID = 4
	var section: = track_cfg.get_section(ID)
	.init_level_track(section, ID)


func _ready() -> void:
	apply_custom_background()


func apply_custom_background() -> void:
	root.remove_child(bd)
	bd.call_deferred("free")
	root.add_child(custom_background)


static func create_for_cfg() -> void:
	var level_id = 2
	var track_id = 4
	var resource = "res://Game/Level2/Level2_0/Level2_0.tscn"
	var texture = "res://Game/Level2/assets/slides/track-2_0.png"
	var num_win = 6
	var init_time_level = 40
	var price = 20
	var issue = "TODO: Level in progress %"
	var state = LevelTrackStates.PAY
	GameData.track_cfg.create(track_id, level_id, issue, resource, texture, num_win, init_time_level, price, state)
