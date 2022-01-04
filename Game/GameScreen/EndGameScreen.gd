extends Control
class_name EndGameScreen

onready var pause_rect:ColorRect = get_node("PauseRect")
onready var label:Label = get_node("PauseRect/Label")
onready var title:Label = get_node("PauseRect/Title")
onready var description:Label = get_node("PauseRect/Description")

var default_rect_color: = Color(0.40, 0.25, 0.56, 1.00) 	 # 67428f
var rect_color_win: = Color(0.25, 0.56, 0.34, 1.00) 		 # 428f57
var rect_color_lose: = Color(0.56, 0.25, 0.25, 1.00)

var default_title: String = 'Title menu: You are win or You are fail'
var title_value: String = ''

var default_description: String = 'Long description about level progress'
var description_value:String = ''

const TIME_UP_TEXT: String = 'Your time is up'
const BROKE_BIKE_TEXT: String = 'You broke your bike'
const FELL_TEXT: String = 'You fell and you need to try again'
const HIT_PERSON_TEXT: String = 'You hit a person'

enum TitleChoices {
	TIME_UP, BROKE_BIKE, FELL, HIT_PERSON, 
	WIN_PLAYER 
}


func _ready() -> void:
	if PlayerData.lives == 0:
		title.set_text(default_title) if title_value == '' else title.set_text(title_value)
		description.set_text(default_description) if description_value == '' else description.set_text(description_value)
		pause_rect.color = default_rect_color

	if PlayerData.type_title > -1:
		set_title_and_rect_color()
		set_description()
	
	# set win items
	var rm_item_res_value: Label = $PauseRect/ResourceContainer/RMItemResource/Value
	var hourgrass_item_res_value: Label = $PauseRect/ResourceContainer/HourgrassItemResource/Value
	rm_item_res_value.set_text(str(PlayerData.rms))
	hourgrass_item_res_value.set_text(str(PlayerData.time_level_count))
	
	var travel_time = 'Travel time:           %s' % [timer_format(PlayerData.time_level)]
	var distance_travel = 'Distance traveled: %d m' % [PlayerData.score / 100]
	label.set_text(travel_time + '\r\n'  + distance_travel)
	
	# Update writes to .cfg files
	if GameData.current_track:
		var track_cfg: TrackCfg = load(PathData.TRACK_MODEL).new()
		var player_track_cfg: PlayerTrackCfg = load(PathData.PLAYER_TRACK_MODEL).new()
		
		var track_section: = track_cfg.get_section(GameData.current_track.ID)
		var player_track_section: = track_section.replace(track_cfg.prefix, player_track_cfg.prefix)
	
		track_cfg.set_state(track_section, LevelTrackStates.FAIL)
		player_track_cfg.set_best_time(player_track_section, timer_format(PlayerData.time_level))
		# player_track_cfg.set_best_time(GameData.current_level.get_section(), timer_format(PlayerData.time_level))


func set_title_and_rect_color():
	if PlayerData.type_title == TitleChoices.WIN_PLAYER:
		title.set_text('You win!')
		pause_rect.color = rect_color_win
	else:
		title.set_text('You lose')
		pause_rect.color = rect_color_lose


func set_description():
	if PlayerData.type_title == TitleChoices.WIN_PLAYER:
		description.set_text(PlayerData.current_level.title)
	elif PlayerData.type_title == TitleChoices.FELL:
		description.set_text(FELL_TEXT)
	elif PlayerData.type_title == TitleChoices.BROKE_BIKE:
		description.set_text(BROKE_BIKE_TEXT)
	elif PlayerData.type_title == TitleChoices.TIME_UP:
		description.set_text(TIME_UP_TEXT)
	elif PlayerData.type_title == TitleChoices.HIT_PERSON:
		description.set_text(HIT_PERSON_TEXT)


func timer_format(time):	
	return "%02d:%02d:%02d" % [
		fmod(time, 60 * 60) / 60,
		fmod(time, 60),
		fmod(time, 1) * 100
	]
