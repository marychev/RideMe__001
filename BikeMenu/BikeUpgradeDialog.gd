extends PopupDialog

const POWER_PRICE = 1
const SPEED_PRICE = 1
const JUMP_PRICE = 10

onready var field_log: FieldLog = preload("res://Game/scripts/FieldLog.gd").new()
onready var title: = "Upgrade "

onready var player_rms: = PlayerData.rms
onready var selected_rms: = 0

var power_added_rms: = 0
var speed_added_rms: = 0
var jump_added_rms: = 0


func _ready():
	field_log.target = $Container
	set_rm_counter()


func _on_btn_power_add_pressed() -> void:
	if on_btn_added(POWER_PRICE):
		power_added_rms += POWER_PRICE
		$Container/VBoxContainer/GridContainer/PowerAdded.set_text("+" + str(power_added_rms))


func _on_btn_power_del_pressed() -> void:
	if on_btn_del(POWER_PRICE) and power_added_rms > 0:
		power_added_rms -= POWER_PRICE
		var _char = "+" if power_added_rms > 0 else "-"
		$Container/VBoxContainer/GridContainer/PowerAdded.set_text(
			_char + str(power_added_rms))


func _on_btn_power_add_released() -> void:
	$Container/VBoxContainer/GridContainer.modulate.a = 1


func _on_btn_power_del_released() -> void:
	$Container/VBoxContainer/GridContainer.modulate.a = 1


func _on_btn_speed_add_pressed() -> void:
	if on_btn_added(SPEED_PRICE):
		speed_added_rms += SPEED_PRICE
		$Container/VBoxContainer/GridContainer/SpeedAdded.set_text("+" + str(speed_added_rms))


func _on_btn_speed_add_released() -> void:
	$Container/VBoxContainer/GridContainer.modulate.a = 1


func _on_btn_speed_del_pressed() -> void:
	if on_btn_del(SPEED_PRICE) and speed_added_rms > 0:
		speed_added_rms -= SPEED_PRICE
		var _char = "+" if speed_added_rms > 0 else ""
		$Container/VBoxContainer/GridContainer/SpeedAdded.set_text(
			_char + str(speed_added_rms))


func _on_btn_speed_del_released() -> void:
	$Container/VBoxContainer/GridContainer.modulate.a = 1


func _on_btn_jump_add_pressed() -> void:
	if on_btn_added(JUMP_PRICE):
		jump_added_rms += JUMP_PRICE
		$Container/VBoxContainer/GridContainer/JumpAdded.set_text("+" + str(jump_added_rms))


func _on_btn_jump_del_pressed() -> void:
	if on_btn_del(JUMP_PRICE) and jump_added_rms > 0:
		jump_added_rms -= JUMP_PRICE
		var _char = "+" if jump_added_rms > 0 else ""
		$Container/VBoxContainer/GridContainer/JumpAdded.set_text(
			_char + str(jump_added_rms))


func _on_btn_jump_add_released() -> void:
	$Container/VBoxContainer/GridContainer.modulate.a = 1


func _on_btn_jump_del_released() -> void:
	$Container/VBoxContainer/GridContainer.modulate.a = 1


func open(player_bike: Node) -> void:
	popup()

	if player_bike:
		title += player_bike.title
		find_node("Title").set_text(title)
		find_node("PowerValue").set_text(str(player_bike.max_power))
		find_node("SpeedValue").set_text(str(player_bike.max_speed))
		find_node("JumpValue").set_text(str(player_bike.max_height_jump))
	
	popup_centered()


func set_rm_counter() -> void:
	$RMCounter/Background/Value.set_text(
		str(player_rms) + " / " + str(selected_rms)
	)


func on_btn_added(price) -> bool:
	field_log.clear()
	$Container/VBoxContainer/GridContainer.modulate.a = 0.5
	
	if player_rms > selected_rms:
		selected_rms += price
		set_rm_counter()
		return true
	else:
		field_log.error("Have not enough the Rms")
		return false
		

func on_btn_del(price) -> bool:
	field_log.clear()
	$Container/VBoxContainer/GridContainer.modulate.a = 0.5
	
	if selected_rms > 0:
		selected_rms -= price
		set_rm_counter()
		return true
	return false

