extends Node

onready var audio_player: AudioStreamPlayer2D = get_node("../AudioStreamPlayer2D")


func _ready():
	print_debug('!!!!!!!!')
	
	if OS.get_name() == 'HTML5':
		var window = JavaScript.get_interface("window")
		# window.onbeforeunload = _callback_ref
		window.onblur = _callback_ref_stop_audio
		window.onfocus = _callback_ref_play_audio


# -- BEGIN HTML JS callbacks 

var _callback_ref_stop_audio = JavaScript.create_callback(self, "_callback_stop_audio")
var _callback_ref_play_audio = JavaScript.create_callback(self, "_callback_play_audio")

func _callback_stop_audio(args):
	# Get the first argument (the DOM event in our case).
	var js_event = args[0]
	# Call preventDefault and set the `returnValue` property of the DOM event.
	js_event.preventDefault()
	# js_event.returnValue = ''
	$"../AudioStreamPlayer2D"
	$AudioStreamPlayer2D.stop()
	
func _callback_play_audio(args):
	$AudioStreamPlayer2D.play()

# -- END HTML JS callbacks 

