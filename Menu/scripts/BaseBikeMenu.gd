extends MarginContainer
class_name BaseBikeMenu

var path_data: PathData = preload("res://Autoload/PathData.gd").new()
var selected_node: Node
var title: String = "no"

onready var field_log: FieldLog = preload("res://Game/scripts/FieldLog.gd").new()

onready var sprite: Sprite = $TextureRect/SliderContainer/Detail/Image/Sprite
onready var menu_options = $TextureRect/SliderContainer/Detail/MenuOptions
onready var btn_current_node: Node = $TextureRect/SliderContainer/Buttons/Current
onready var btn_refit: TextureButton = $TextureRect/ButtonContainer/btn_refit
onready var btn_pay: TextureButton = $TextureRect/ButtonContainer/btn_pay


func _ready():
	$TextureRect/RMCounter/Background/Value.set_text(str(PlayerData.rms))
	
	btn_refit.modulate.a = 0.4
	btn_current_node.flat = bool(PlayerData.player_bike != null)
	
	field_log.target = $TextureRect


func init_slide(node: Node) -> void:
	selected_node = node
	set_title(node)
	sprite.set_texture(node.texture)


func set_title(node: Node, title = "") -> void:
	title = title if title else node.title
	$TextureRect/Title.text = title


func _on_Current_pressed() -> void:
	field_log.clear()
	btn_current_node.flat = true


func _on_btn_menu_pressed() -> void:
	var main_menu: String = path_data.RES_MAIN_MENU_TSCN
	get_tree().change_scene(main_menu)
