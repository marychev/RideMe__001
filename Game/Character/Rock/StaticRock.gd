extends StaticBody2D

var path_data: PathData = preload("res://Autoload/PathData.gd").new()
var _player_stomp_detecter = load(path_data.PATH_PLAYER_STOMP_DETECTER)

onready var player_stomp_detecter = _player_stomp_detecter.new()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func _on_StompDetector_body_entered(body: Node) -> void:
	if "Player" == body.name:
		player_stomp_detecter.player = body
		player_stomp_detecter.on_player_entered()
