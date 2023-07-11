class_name BlurAndFocus
extends Node

var audio_stream_player: AudioStreamPlayer2D
var _callback_ref_stop_audio = JavaScript.create_callback(self, "_callback_stop_audio")
var _callback_ref_play_audio = JavaScript.create_callback(self, "_callback_play_audio")


func _ready():
	if OS.get_name() == 'HTML5':
		if has_node("../AudioStreamPlayer2D"):
			audio_stream_player = get_node("../AudioStreamPlayer2D")
		elif has_node("../Player/Music"):
			audio_stream_player = get_node("../Player/Music")

		var window = JavaScript.get_interface("window")
		# window.onbeforeunload = _callback_ref
		window.onblur = _callback_ref_stop_audio
		window.onfocus = _callback_ref_play_audio


func _callback_stop_audio(args):
	# Get the first argument (the DOM event in our case).
	var js_event = args[0]
	# Call preventDefault and set the `returnValue` property of the DOM event.
	js_event.preventDefault()
	# js_event.returnValue = ''
	audio_stream_player.stop()


func _callback_play_audio(args):
	audio_stream_player.play()
