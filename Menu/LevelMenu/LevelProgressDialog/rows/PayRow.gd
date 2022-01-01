extends ActiveRow
class_name PayRow

onready var field_log: FieldLog = preload("res://Game/scripts/FieldLog.gd").new()


func _ready():
	._ready()
	
	field_log.target = $Title
	
	if PlayerData.rms < int($Price.text.replace("rm", "")):
		$PayBtn.modulate.a = 0.4
		$PayBtn.disabled = true


func set_current_level(level: Node2D) -> void:
	.set_current_level(level)
	
	if level:
		$Price.set_text("%d rm" % [current_level.price])


func _on_PayBtn_pressed():
	var level_cfg: LevelCfg = load("res://config/LevelCfg.gd").new()
	var track_cfg: TrackCfg = load("res://config/TrackCfg.gd").new()
	var player_track_cfg: PlayerTrackCfg = load("res://config/PlayerTrackCfg.gd").new()
	
	if not current_level:
		var message = "You have not a current level"
		field_log.error(message)
		return
	
	# var player_track_SECTION: String = current_level.SECTION.replace("LevelTrack", "PlayerTrack")
	var current_track_SECTION: = track_cfg.get_section(current_level.ID)
	var player_track_SECTION: = current_track_SECTION.replace(track_cfg.prefix, player_track_cfg.prefix)
	
	if player_track_cfg.config.has_section(player_track_SECTION):
		var message = "You have already paid for this track %s" % player_track_SECTION
		field_log.info(message)
		return
	
	if PlayerData.rms < current_level.price:
		field_log.error("Need to more Rms!")
		return
		
	PlayerData.set_rms(PlayerData.rms - current_level.price)
	player_track_cfg.create(current_track_SECTION, player_track_SECTION)
	track_cfg.set_state(current_track_SECTION, LevelTrackStates.ACTIVE)
	
	set_current_level(current_level)

	var message = "The %s track was paid!" % player_track_SECTION
	field_log.success(message)
	# yield(get_tree().create_timer(0.4), "timeout")
	
	if has_node("/root/LevelMenu"):
		var level_menu: LevelMenu = get_node("/root/LevelMenu")
		level_menu._on_btn_refit_pressed()


