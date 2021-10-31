extends Control
class_name EndGameScreen

onready var pause_rect:ColorRect = get_node("PauseRect")
onready var label:Label = get_node("PauseRect/Label")
onready var title:Label = get_node("PauseRect/Title")
onready var description:Label = get_node("PauseRect/Description")


var default_rect_color: = Color(0.40, 0.25, 0.56, 1.00)  # 67428f
var rect_color_win = Color(0.25, 0.56, 0.34, 1.00) 		 # 428f57
var rect_color_lose = Color(0.56, 0.25, 0.25, 1.00)

var default_title: String = 'Title menu: You are win or You are fail'
var title_value: String = ''

var default_description: String = 'Long description about level progress'
var description_value:String = ''


const TIME_UP_TEXT: String = 'Your time is up'
const BROKE_BIKE_TEXT: String = 'You broke your bike'
const FELL_TEXT: String = 'You fell and you need to try again'
const HIT_PERSON_TEXT: String = 'You hit a person'
enum FailTitleChoices {TIME_UP, BROKE_BIKE, FELL, HIT_PERSON}


func _ready() -> void:
	if PlayerData.lives == 0:
		title.set_text(default_title) if title_value == '' else title.set_text(title_value)
		description.set_text(default_description) if description_value == '' else description.set_text(description_value)
		pause_rect.color = Color(0.25, 0.23, 0.32, 1.00)
		
	if PlayerData.fail_type_title:
		if PlayerData.fail_type_title == FailTitleChoices.FELL:
			title.set_text('You lose')
			description.set_text(FELL_TEXT)
			pause_rect.color = rect_color_lose

	var RM_item_res_value:Label = $PauseRect/ResourceContainer/RMItemResource/Value
	RM_item_res_value.set_text(str(PlayerData.rms))
	
	var travel_time = 'Travel time is:        %s' % [timer_format(PlayerData.time_level)]
	var distance_travel = 'Distance traveled: %.2f' % [PlayerData.score / 100]
	label.set_text(travel_time + '\r\n'  + distance_travel)


func timer_format(time):
	return "%02d : %02d : %02d" % [
		fmod(time, 60 * 60) / 60,
		fmod(time, 60),
		fmod(time, 1) * 100
	]
