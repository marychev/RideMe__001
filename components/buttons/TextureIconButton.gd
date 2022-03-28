extends TextureButton
class_name TextureIconButton

export (String) var title
export (Texture) var icon
export (String, FILE) var change_scene
export (bool) var is_flicker


const audio_btn_pressed = preload("res://media/ui/btn_pressed.wav")
const audio_btn_run = preload("res://media/ui/btn_run.wav")
const audio_btn_pay = preload("res://media/ui/btn_pay.wav")
const audio_btn_error = preload("res://media/ui/btn_error.wav")

var type


func _ready():
	set_title(title)
	set_icon(icon)
	
	if is_flicker:
		anim_flicker()


func _on_pressed():
	if not change_scene.empty():
		yield(get_tree().create_timer(0.4), "timeout")
		get_tree().change_scene(change_scene)
	else:
		print("[warn] TextureIconButton: Change scene does not init")


func _on_button_down():
	if "Error" == type:
		$AudioStreamPlayer2D.set_stream(audio_btn_error)
	elif "Run" == type:
		$AudioStreamPlayer2D.set_stream(audio_btn_run)
	elif "Pay" == type:
		$AudioStreamPlayer2D.set_stream(audio_btn_pay)
	else:
		$AudioStreamPlayer2D.set_stream(audio_btn_pressed)

	$AudioStreamPlayer2D.play()


func set_title(val) -> void:
	if not val.empty():
		$Label.set_text(val)


func set_icon(val) -> void:
	if val:
		$Icon.texture = val


func anim_flicker() -> void:
	is_flicker = true
	$AnimPlayer.play("flicker")






