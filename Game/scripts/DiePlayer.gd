extends Node
class_name DiePlayer

var player: Player
var _end_game_scr = load(PathData.END_GAME_SCREEN)
var end_game_scr = _end_game_scr.instance()


func from_time_up(_player: Player) -> void:
	init_player(_player)
	PlayerData.set_type_title(end_game_scr.TitleChoices.TIME_UP)
	PlayerData.set_score(player.global_position.x)
	die(true)


func from_hir_person(_player: Player) -> void:
	init_player(_player)
	PlayerData.set_type_title(end_game_scr.TitleChoices.HIT_PERSON)
	PlayerData.set_score(player.global_position.x)
	die()


func from_fell(_player: Player):
	init_player(_player)
	PlayerData.set_type_title(end_game_scr.TitleChoices.FELL)
	PlayerData.set_score(player.global_position.x)
	die(true)
	

func from_broke_bike(_player: Player):
	init_player(player)
	PlayerData.set_type_title(end_game_scr.TitleChoices.BROKE_BIKE)
	PlayerData.set_score(player.global_position.x)
	die()


func die(force: bool = false) -> void:
	if force: 
		PlayerData.lives = 0
	
	if PlayerData.lives <= 0:
		
		yield(player.get_tree().create_timer(4), "timeout")
		
		# var game_menu: GameScreenPause = get_node(PathData.PATH_GAME_SCREEN_PAUSE)
		# var game_menu: GameScreenPause = load(PathData.RES_GAME_SCREEN_PAUSE).instance()
		# game_menu.paused = true

		if is_instance_valid(player):
			player.get_tree().change_scene(PathData.END_GAME_SCREEN)
			player.queue_free()
		

func init_player(_player: Player) -> void:
	if not is_instance_valid(player):
		player = _player
