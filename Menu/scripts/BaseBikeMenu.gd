extends MarginContainer
class_name BaseBikeMenu

var selected_node: Node2D  # Track / Level / Bike - ?

onready var field_log: FieldLog = preload("res://Game/scripts/FieldLog.gd").new()

onready var sprite: Sprite = $TextureRect/SliderContainer/Detail/Image/Sprite
onready var menu_options: VBoxContainer = $TextureRect/SliderContainer/Detail/MenuOptions
onready var btn_current_node: Button = $TextureRect/SliderContainer/Buttons/Current
onready var btn_refit: TextureButton = $TextureRect/ButtonContainer/btn_refit
onready var btn_pay: TextureButton = $TextureRect/ButtonContainer/btn_pay


func _ready():
	$TextureRect/RMCounter/Background/Value.set_text(str(PlayerData.rms))
	
	btn_refit.modulate.a = 0.4
	if GameData.current_level:
		btn_refit.modulate.a = 1
		
	btn_current_node.flat = bool(PlayerData.player_bike != null)
	
	field_log.target = $TextureRect


func _on_Current_pressed() -> void:
	field_log.clear()
	btn_current_node.flat = true


func _on_btn_menu_pressed() -> void:
	var main_menu: String = PathData.RES_MAIN_MENU_TSCN
	get_tree().change_scene(main_menu)


func init_slide(node: Node2D) -> void:
	if is_instance_valid(node):
		selected_node = node
		set_title(node)
		sprite.set_texture(node.texture)


func set_title(node: Node2D) -> void:
	if is_instance_valid(node):
		$TextureRect/Title.text = node.title if node.title else "undefined"
