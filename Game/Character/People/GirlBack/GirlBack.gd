extends RigidBody2D
class_name GirlBack

var animation: AnimationPlayer


func _ready() -> void:
	set_physics_process(false)


func _on_tree_entered() -> void:
	animation = $AnimationPlayer
	animation.play("walk")


func _on_StopmDetector_body_entered(body: Node) -> void:
	if "Player" == body.name:
		var animate_people = load(PathData.PATH_ANIMATE_PEOPLE).new()
		animate_people.do_collision(animation, body)

		body.set_speed(-body.speed)
		body.anim_player.play('collision')
