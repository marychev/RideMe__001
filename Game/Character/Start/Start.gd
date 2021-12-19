extends Area2D
class_name Start

var use_as_finish: bool = false
var path_data: PathData = preload("res://Autoload/PathData.gd").new()

func _on_Start_body_entered(body: Node) -> void:
	if body.name == 'Player' and use_as_finish:
		var end_game_scr = load(path_data.END_GAME_SCREEN).instance()

		PlayerData.set_type_title(end_game_scr.TitleChoices.WIN_PLAYER)
		PlayerData.set_score(body.global_position.x)
		
		var die_player = load(path_data.PATH_DIE_PLAYER).new()
		die_player.player = body
		die_player.die(true)
