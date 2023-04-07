extends TextureIconButton
class_name ExitBtn


func _pressed():
	if OS.get_name() == 'HTML5':
		self.change_scene = "res://SplashScreen/SplashScreen.tscn"
		._on_pressed()
	else:
		get_tree().quit()
