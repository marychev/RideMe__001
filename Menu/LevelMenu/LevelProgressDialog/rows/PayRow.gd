extends ActiveRow
class_name PayRow

onready var field_log: FieldLog = preload("res://Game/scripts/FieldLog.gd").new()


func _ready():
	field_log.target = $Title
	
	if PlayerData.rms < int($Price.text.replace("rm", "")):
		$PayBtn.modulate.a = 0.4
		$PayBtn.disabled = true


func _on_PayBtn_pressed():
	if not _track:
		var message = "You have not an initial track"
		field_log.error(message)
		return
	
	var _track_section: = track_cfg.get_section(_track.id)
	var player_track_section: = _track_section.replace(track_cfg.prefix, player_track_cfg.prefix)
	
	if player_track_cfg.config.has_section(player_track_section):
		var message = "You have already paid for this track %s" % player_track_section
		field_log.info(message)
		return
	
	if PlayerData.rms < _track.price:
		field_log.error("Need to more Rms!")
		return
		
	PlayerData.set_rms(PlayerData.rms - _track.price)
	player_track_cfg.create(_track_section, player_track_section)
	track_cfg.set_state(_track_section, LevelTrackStates.ACTIVE)
	
	var message = "The %s track was paid!" % player_track_section
	field_log.success(message)

	if has_node("/root/LevelMenu"):
		var level_menu: LevelMenu = get_node("/root/LevelMenu")
		level_menu._on_btn_refit_pressed()


func set_price() -> void:
	$Price.set_text("%s rm" % [str(_track.price)])

func set_time() -> void:
	$Time.set_text("..:..")
