extends RigidBody2D
class_name GirlBack

onready var animation: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	set_physics_process(false)


func _on_tree_entered() -> void:
	animation.play("walk")


func _on_StopmDetector_body_entered(body: Node) -> void:
	if "Player" == body.name:
		var animate_people = load(PathData.PATH_ANIMATE_PEOPLE).new()
		animate_people.do_collision(animation, body)

		body.set_speed(-body.max_speed)
		body.anim_player.play('collision')
