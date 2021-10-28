extends Node
class_name PlayerStompDetecter

var player: KinematicBody2D


func on_player_entered() -> void:
	if "Player" == player.name:
		
		print('_on_StompDetector_body_entered__', player.name)
		print('-------------------------------------------')
		
		player.anim_player.stop()
		player.anim_player.play("collision")
		PlayerData.lives -= 1
		
		if player.speed.x > player.max_speed / 2:
			PlayerData.lives -= 20
		elif player.speed.x > (player.max_speed * 90 / 100):
			PlayerData.lives -= 50
		
		if PlayerData.lives > 0:
			player.set_speed(-player.speed.x / 2)
		else:
			player.die()
