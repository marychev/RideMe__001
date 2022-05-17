extends KinematicBody2D
class_name MovingPlatform

const MOVE_SPEED = 120

var has_move_up = false
onready var start_pos_y = position.y


func _ready():
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	if has_move_up:
		move_up(delta)


func move_up(dt: float):
	if position.y > start_pos_y:
		position.y -= dt * MOVE_SPEED


func move_down(dt: float):
	position.y += dt * MOVE_SPEED


func _on_VisibilityEnabler2D_screen_exited() -> void:
	queue_free()
