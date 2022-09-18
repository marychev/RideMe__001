extends BaseArea2D
class_name Grass

var is_into: bool = false
var player: Player = null


func _on_body_entered(body):
	if body.name == "Player":
		is_into = true
		$Particles2D.emitting = is_into
		player = body 
		
		._on_body_entered(player)
		if player.anim_player.current_animation != PlayerData.ANIMATION_SUCCESS:
			player.anim_player.play(PlayerData.ANIMATION_SUCCESS)


func _process(delta):
	if is_into and player:
		if player.power > 100:
			player.power -= 1
		if player._velocity.x > 100:
			player._velocity.x -= 2
		if PlayerData.lives < 100:
			PlayerData.lives += 1


func _on_VisibilityEnabler_screen_exited() -> void:
	queue_free()


func _on_Grass_body_exited(body):
	is_into = false
	player = null
