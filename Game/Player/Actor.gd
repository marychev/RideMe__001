extends KinematicBody2D
class_name Actor

const FLOOR_NORMAL: = Vector2.UP

export var gravity: = 42.0
export var speed: = Vector2(10.0, 800.0)

var _velocity: = Vector2.ZERO

"""func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	_velocity.y = max(_velocity.y, speed.y)
	_velocity = move_and_slide(_velocity)
"""
