extends "res://Game/GameScreen/GamePauseDie.gd"
class_name GamePauseWin


var rect_color_win: = Color(0.25, 0.56, 0.34, 0.8) 		 # 428f57


func do_init(title: Label, pause_rect: ColorRect) -> void:
	if GameData.current_track.are_you_win() and PlayerData.type_title == TitleChoices.WIN_PLAYER:
		var next_level_btn: TextureIconButton = pause_rect.get_node("Container/NextLevelBtn")
		next_level_btn.visible = true
		
		set_title_and_rect_color(title, pause_rect)
		set_screen_items(pause_rect)
		update_as_win_cfg()


func set_screen_items(pause_rect: ColorRect) -> void:
	pause_rect.get_node("LabelItems").visible = true
	pause_rect.get_node("ResourceContainer").visible = true
	
	var rm_item_res_value: Label = pause_rect.get_node("ResourceContainer/RMItemResource/Value")
	var hourgrass_item_res_value: Label = pause_rect.get_node("ResourceContainer/HourgrassItemResource/Value")
	rm_item_res_value.set_text(str(PlayerData.rms_count))
	hourgrass_item_res_value.set_text(str(PlayerData.time_level_count))
	
	var travel_time = 'Travel time:..................%s' % [timer_format(PlayerData.time_level)]
	var distance_travel = 'Distance traveled:....%d m' % [PlayerData.score / 100]
	pause_rect.get_node("LabelItems").set_text(travel_time + '\r\n'  + distance_travel)
	

func set_title_and_rect_color(title: Label, pause_rect: ColorRect):
	title.set_text("You win!")
	pause_rect.get_node("Description").visible = true
	pause_rect.get_node("Description").set_text(get_info())
	pause_rect.color = rect_color_win


func get_info() -> String:
	# TODO: Nill + string error
	if GameData.current_track.title:
		return GameData.current_track.title + ": " + GameData.current_track.issue.to_lower()
	return ": " + GameData.current_track.issue.to_lower()


func update_as_win_cfg():
	if GameData.current_track:
		var track_cfg: TrackCfg = load(PathData.TRACK_MODEL).new()
		var player_track_cfg: PlayerTrackCfg = load(PathData.PLAYER_TRACK_MODEL).new()
		var track_section: = track_cfg.get_section(GameData.current_track.ID)
		var player_track_section: = track_section.replace(track_cfg.prefix, player_track_cfg.prefix)
		
		track_cfg.set_state(track_section, LevelTrackStates.PASSED)
		player_track_cfg.set_best_time(player_track_section, timer_format(PlayerData.time_level))
		
		print("SAVE RMS: update_as_win_cfg", PlayerData.rms, PlayerData.rms_count)
		PlayerData.rms_count = 0
		PlayerData.save_rms(PlayerData.rms)
		print("---------")
