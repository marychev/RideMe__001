class_name Time
extends VBoxContainer

var time = 0
var timer_on = false
var player_on = false
var PlayerScn


func start(delta, player_scn = null):
	timer_on = true
	time += delta
	$Container/Value.text = timer_format()
	
	if player_scn != null:
		player_on = true
		PlayerScn = player_scn
		$Container/Extra.text = player_format()


func timer_format():
	return "%02d : %02d : %02d" % [
		fmod(time, 60 * 60) / 60,
		fmod(time, 60),
		fmod(time, 1) * 100,
	]


func player_format():
	return """
	Velocity: %d, %d
	Position: %d, %d
	""" % [
		PlayerScn._velocity.x, PlayerScn._velocity.y,
		PlayerScn.position.x, PlayerScn.position.y,
	]
