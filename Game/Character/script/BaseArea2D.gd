extends Area2D
class_name BaseArea2D

var bike_speed
var bike_power


func _on_body_entered(body):
	set_bike_parameters(body)
	
	body.get_node('AudioMove').set_stream(body.audio_stop)
	body.get_node('AudioMove').play()


func _ready() -> void:
	set_physics_process(false)


func set_bike_parameters(player: Player):
	if not bike_speed:
		bike_speed = player.max_speed / 2
		bike_power = player.max_power / 2
			
		player.set_speed(bike_speed)
		player.set_power(bike_power)
