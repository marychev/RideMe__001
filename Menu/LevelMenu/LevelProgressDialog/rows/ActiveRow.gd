extends HBoxContainer
class_name ActiveRow

const DEFAULT_TITLE: String = "<0.0: collect the %s hourgrass>"

var path_data: PathData = preload("res://Autoload/PathData.gd").new()
var current_level: BaseLevel


func _ready() -> void:
	set_current_level(current_level)
	set_title()


func _on_PlayBtn_pressed():
	GameData.current_level = current_level
	$PlayBtn._on_pressed()


func set_title() -> void:
	if current_level:
		var title = "%d/%d: %s" % [
			current_level.level,
			current_level.track,
			current_level.issue
		]
		$Title.set_text(title)


func set_current_level(level: BaseLevel) -> void:
	# if not level and not GameData.current_level and not current_level:
	#	level = preload("res://Game/Level/Level_Train/Level_Train.tscn").instance()
	if level:
		current_level = level
		GameData.current_level = current_level
