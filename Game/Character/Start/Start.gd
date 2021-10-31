extends Area2D
class_name Start


func _on_Start_body_entered(body: Node) -> void:
	var todo = "\r\nTodo: \n" +\
		"O. Need to define that it is the Finish, no Start.\n" +\
		"1. Added the position of road collision instead player.\n" +\
		"2. Show to the Finish screne `title` and so one.\n"
	print(todo)
	
	if body.name == 'Player':
		var end_game_scr = load(PlayerData.END_GAME_SCREEN).instance()

		PlayerData.set_type_title(end_game_scr.TitleChoices.WIN_PLAYER)
		PlayerData.set_score(body.global_position.x)
		
		var die_player = load(PlayerData.PATH_DIE_PLAYER).new()
		die_player.player = body
		die_player.die(true)
