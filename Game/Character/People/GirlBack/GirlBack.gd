extends RigidBody2D
class_name GirlBack

var animation: AnimationPlayer
var audio_girl_scream = preload("res://media/characters/girl_scream.wav")
export var start_amination: = true

func _ready() -> void:
	set_physics_process(false)


func _on_tree_entered() -> void:
	if start_amination:
		animation = $AnimationPlayer
		animation.play("walk")


func _on_StopmDetector_body_entered(body: Node) -> void:
	if "Player" == body.name:
		var animate_people = load(PathData.PATH_ANIMATE_PEOPLE).new()
		animate_people.do_collision(animation, body)
		$Audio.set_stream(audio_girl_scream)
		$Audio.play()

		var die_player = load(PathData.PATH_DIE_PLAYER).new()
		die_player.from_hir_person(body)

		# body.get_node('AudioMove').set_stream(body.audio_broke)
		# body.get_node('AudioMove').play()
