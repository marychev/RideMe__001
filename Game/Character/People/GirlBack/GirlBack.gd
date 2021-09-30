extends RigidBody2D

var animation: AnimationPlayer


func _on_tree_entered() -> void:
	if not animation:
		animation = $AnimationPlayer
	
	animation.play("walk")


func collision_with(player: KinematicBody2D):
	animation.play("collision")
