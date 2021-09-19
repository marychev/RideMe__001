extends RigidBody2D
class_name MovingPlatform

onready var start_pos_y = position.y


func _on_MovingPlatform_body_entered(body: Node) -> void:
	print('[_on_MovingPlatform_body_entered]: ', body.name)
	if "Player" == body.name:
		move_down(get_physics_process_delta_time(), body.mass)


func _physics_process(delta: float) -> void:
	if position.y > start_pos_y:
		move_up(delta)


func move_up(dt: float):
	position.y -= 100 * dt
	do_move()


func move_down(dt: float, mass: int):
	position.y += mass * dt
	do_move()


func do_move():
	var xf = Transform2D()
	xf[2] = Vector2(position.x, position.y)
	transform = xf
