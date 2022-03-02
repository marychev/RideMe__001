extends ActiveRow
class_name PayRow

onready var field_log: FieldLog = preload("res://components/field_log/FieldLog.gd").new()


func _ready():
	field_log.target = $Title
	
	if PlayerData.rms < int($Price.text.replace("rm", "")):
		$PayBtn.modulate.a = 0.4
		$PayBtn.disabled = true


func _on_PayBtn_pressed():
	if not _track:
		field_log.error("You have not an initial track")
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

	PlayerData.save_rms(PlayerData.rms - _track.price)
	player_track_cfg.create(_track_section, player_track_section)
	track_cfg.set_state(_track_section, LevelTrackStates.ACTIVE)
	field_log.success("The %s track was paid!" % player_track_section)
	
	yield(get_tree().create_timer(2), "timeout")
	var path_popup = "/root/LevelMenu/LevelProgressDialog"
	if has_node(path_popup):
		var level_popup: = get_node(path_popup)
		level_popup._on_btn_yes_pressed()


func set_price() -> void:
	$Price.set_text("%s rm" % [str(_track.price)])

func set_time() -> void:
	$Time.set_text("..:..")
