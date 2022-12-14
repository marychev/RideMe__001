extends StaticBody2D
class_name RoadBody

export(bool) var has_repeat = false;

var PlayerScn
onready var road_width = $sprite.texture.get_size().x


func repeat_two_sprites():
	if has_repeat:
		_repeat_two_sprites()


func _repeat_two_sprites():
	if not has_repeat:
		push_error("[ERROR] Advice: The 'Has Repeat' variable has not set at 'true'")
		return

	if PlayerScn.position.x > $sprite2.position.x + road_width:
		$sprite.position.x = $sprite2.position.x + road_width
		$Collision.position.x = $sprite2.position.x + road_width
	if PlayerScn.position.x > $sprite.position.x + road_width:
		$sprite2.position.x = $sprite.position.x + road_width
		$Collision2.position.x = $sprite.position.x + road_width


func _on_VisibilityEnabler2D_screen_exited():
	queue_free()
