extends ActiveRow
class_name PayRow


func _ready():
	._ready()
	
	if PlayerData.rms < int($Price.text.replace("rm", "")):
		$PayBtn.modulate.a = 0.4
		$PayBtn.disabled = true


func set_current_level(level: BaseLevel) -> void:
	if not level and not GameData.current_level and not current_level:
		level = preload("res://Game/Level/Level_Train/Level_Train.tscn").instance()

	current_level = level
	GameData.current_level = current_level
