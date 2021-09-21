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
	var vx = -8.8
	var vy = -8.8
	var px = -8.8
	var py = -8.8
	
	if not('Deleted Object' in str(PlayerScn)):
		vx = PlayerScn._velocity.x 
		vy = PlayerScn._velocity.y
		px = PlayerScn.position.x
		py = PlayerScn.position.y
		
	return """
	Velocity: %d, %d
	Position: %d, %d
	""" % [vx, vy, px, py]
