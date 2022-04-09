extends HBoxContainer
class_name ActiveRow   # via BaseClass of the Rows

const audio_btn_pressed = preload("res://media/ui/btn_pressed.wav")
const audio_btn_run = preload("res://media/ui/btn_run.wav")
const audio_btn_pay = preload("res://media/ui/btn_pay.wav")
const audio_btn_error = preload("res://media/ui/btn_error.wav")

var level_cfg: LevelCfg = load(PathData.LEVEL_MODEL).new()
var track_cfg: TrackCfg = load(PathData.TRACK_MODEL).new()
var player_track_cfg: PlayerTrackCfg = load(PathData.PLAYER_TRACK_MODEL).new()
	
var _track: Dictionary


func _on_PlayBtn_pressed() -> void:
	if has_node("/root/LevelMenu") and not _track.empty():
		var track: Level_0 = load(_track.resource).instance()
		get_node("/root/LevelMenu").selected_node = track
		GameData.current_track = track


func set_title() -> void:
	var title := "%d/%d: %s" % [_track.level_id, _track.id, _track.issue]
	$Title.set_text(title)


func set_price() -> void:
	$Price.set_text("$")


func init_track(track: Dictionary) -> void:
	_track = track
	set_title()
	set_price()
