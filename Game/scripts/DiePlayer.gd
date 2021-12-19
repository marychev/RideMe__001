extends Node
class_name DiePlayer

var path_data: PathData = preload("res://Autoload/PathData.gd").new()
var player: KinematicBody2D
var _end_game_scr = load(path_data.END_GAME_SCREEN)
var end_game_scr = _end_game_scr.instance()


func from_time_up(_player: KinematicBody2D) -> void:
	init_player(_player)
	PlayerData.set_type_title(end_game_scr.TitleChoices.TIME_UP)
	PlayerData.set_score(player.global_position.x)
	die(true)


func from_hir_person(_player: KinematicBody2D) -> void:
	init_player(_player)
	PlayerData.set_type_title(end_game_scr.TitleChoices.HIT_PERSON)
	PlayerData.set_score(player.global_position.x)
	die()


func from_fell(_player: KinematicBody2D):
	init_player(_player)
	PlayerData.set_type_title(end_game_scr.TitleChoices.FELL)
	PlayerData.set_score(player.global_position.x)
	die(true)
	

func from_broke_bike(_player: KinematicBody2D):
	init_player(player)
	PlayerData.set_type_title(end_game_scr.TitleChoices.BROKE_BIKE)
	PlayerData.set_score(player.global_position.x)
	die()


func die(force: bool = false) -> void:
	if force: 
		PlayerData.lives = 0
	
	# todo: need to fix
	if PlayerData.lives <= 0:
		player.queue_free()

		player.get_tree().change_scene(path_data.END_GAME_SCREEN)


func init_player(_player: KinematicBody2D) -> void:
	if not is_instance_valid(player):
		player = _player
