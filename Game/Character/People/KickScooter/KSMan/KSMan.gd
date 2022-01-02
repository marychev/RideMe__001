extends "res://Game/Player/Actor.gd"
class_name KSMan

onready var animation: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x


func _physics_process(delta: float) -> void:
	_velocity.y += (gravity * delta) * 10
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y


func _on_StopmDetector_body_entered(body: Node) -> void:
	if "Player" == body.name:
		var animate_people = load(PathData.PATH_ANIMATE_PEOPLE).new()
		animate_people.do_collision(animation, body)

		var die_player = load(PathData.PATH_DIE_PLAYER).new()
		die_player.from_hir_person(self)
