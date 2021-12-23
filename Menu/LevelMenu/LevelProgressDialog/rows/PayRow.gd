extends ActiveRow
class_name PayRow


func _ready():
	._ready()
	
	if PlayerData.rms < int($Price.text.replace("rm", "")):
		$PayBtn.modulate.a = 0.4
		$PayBtn.disabled = true


func set_current_level(level: BaseLevel) -> void:
	.set_current_level(level)
	
	if level:
		$Price.set_text("%d rm" % [current_level.price])
