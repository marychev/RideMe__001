extends RigidBody2D
class_name GirlBack

var animation: AnimationPlayer
var audio_girl_scream = preload("res://media/characters/girl_scream.wav")


func _ready() -> void:
	set_physics_process(false)


func _on_tree_entered() -> void:
	animation = $AnimationPlayer
	animation.play("walk")


func _on_StopmDetector_body_entered(body: Node) -> void:
	print(" - -")
	if "Player" == body.name:
		print("! !")
		
		var animate_people = load(PathData.PATH_ANIMATE_PEOPLE).new()
		animate_people.do_collision(animation, body)
		$Audio.set_stream(audio_girl_scream)
		$Audio.play()

		body.get_node('AudioMove').set_stream(body.audio_broke)
		body.get_node('AudioMove').play()
