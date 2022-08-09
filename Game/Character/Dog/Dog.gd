extends KinematicBody2D

const SPEED_JUMP_ATTACK: float = 1.4

var animate_people = load(PathData.PATH_ANIMATE_PEOPLE).new()
var die_player = load(PathData.PATH_DIE_PLAYER).new()
	
onready var player: Player = get_node("/root/Game/Player")
onready var direction: Vector2 = Vector2.ZERO
onready var is_attack: bool = false



func _physics_process(delta):
	if player and is_attack:
		direction = (player.global_position - global_position).normalized()
		direction = direction * (SPEED_JUMP_ATTACK + delta)
		
		var collision := move_and_collide(direction)
		if collision and collision.collider == player:
			do_attack()
			

	
func _on_MotionDetecter_body_entered(body: Player):
	if body != self and body == player:
		set_is_attack(true)
		


func _on_MotionDetecter_body_exited(body: Player):
	if body != self and body == player:
		set_is_attack(false)


func set_is_attack(val: bool) -> void:
	is_attack = val
	$Sprite.flip_h = player.position.x < position.x
	
	if is_attack:
		$Audio.play()
		$Sprite.play("run")
	else:
		$Audio.stop()
		$Sprite.play("wait")


func do_attack():
	print('TODO: jump Dog')
	position.x += 180
	position.y += 18

	animate_people.do_collision(AnimationPlayer.new(), player)
	player.power = 0	
	die_player.from_bitten_by_dog(player)
	
	set_is_attack(false)
