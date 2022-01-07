extends Area2D
class_name Start

var use_as_finish: bool = false


func _on_Start_body_entered(body: KinematicBody2D) -> void:
	
	print("_on_Start_body_entered: ", GameData.current_track.are_you_win())
	
	if body.name == 'Player' and GameData.current_track.are_you_win():
		finished(body)

		"""
		var end_game_scr = load(PathData.END_GAME_SCREEN).instance()
		PlayerData.set_type_title(end_game_scr.TitleChoices.WIN_PLAYER)
		PlayerData.set_score(body.global_position.x)
		
		var die_player = load(PathData.PATH_DIE_PLAYER).new()
		die_player.player = body
		die_player.die(true)"""


func finished(player: Player):
	var tree: SceneTree = player.get_tree()
	var pause_screen: GameScreenPause = tree.current_scene.get_node("GUI/Canvas/GameScreenPause")

	yield(player.get_tree().create_timer(1), "timeout")
	
	if is_instance_valid(pause_screen):
		pause_screen.set_paused(true)
		var continue_btn: Button = pause_screen.get_node("PauseRect/Container/ContinueBtn")
		continue_btn.visible = false
	
		var pause_die = preload("res://Game/GameScreen/GamePauseDie.gd").new()
		pause_die.do_init(pause_screen.title, pause_screen.pause_rect)
		# player.queue_free() ????
