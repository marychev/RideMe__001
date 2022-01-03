extends PopupDialog

onready var field_log: FieldLog = preload("res://Game/scripts/FieldLog.gd").new()
onready var btn_no:TouchScreenButton  = $Nine/ButtonContainer/btn_no
onready var btn_yes:TouchScreenButton  = $Nine/ButtonContainer/btn_yes

const POWER_PRICE = 1
const SPEED_PRICE = 1
const JUMP_PRICE = 10

onready var title: = "Upgrade "
onready var grid:GridContainer = $Nine/Grid
onready var power_added:Label = grid.get_node("PowerAdded")
onready var power_value:Label = grid.get_node("PowerValue")
onready var speed_added:Label = grid.get_node("SpeedAdded")
onready var speed_value:Label = grid.get_node("SpeedValue")
onready var jump_added:Label = grid.get_node("JumpAdded")
onready var jump_value:Label = grid.get_node("JumpValue")

var power_added_rms: = 0
var speed_added_rms: = 0
var jump_added_rms: = 0

var selected_rms: = 0


func _ready():
	field_log.target = $"."


func _on_btn_power_add_pressed() -> void:
	if on_btn_added(POWER_PRICE):
		power_added_rms += POWER_PRICE
		power_added.set_text("+" + str(power_added_rms))


func _on_btn_power_del_pressed() -> void:
	if on_btn_del(POWER_PRICE) and power_added_rms > 0:
		power_added_rms -= POWER_PRICE
		var _char = "+" if power_added_rms > 0 else "-"
		power_added.set_text(_char + str(power_added_rms))


func _on_btn_power_add_released() -> void:
	grid.modulate.a = 1


func _on_btn_power_del_released() -> void:
	grid.modulate.a = 1


func _on_btn_speed_add_pressed() -> void:
	if on_btn_added(SPEED_PRICE):
		speed_added_rms += SPEED_PRICE
		speed_added.set_text("+" + str(speed_added_rms))


func _on_btn_speed_add_released() -> void:
	grid.modulate.a = 1


func _on_btn_speed_del_pressed() -> void:
	if on_btn_del(SPEED_PRICE) and speed_added_rms > 0:
		speed_added_rms -= SPEED_PRICE
		var _char = "+" if speed_added_rms > 0 else ""
		speed_added.set_text(_char + str(speed_added_rms))


func _on_btn_speed_del_released() -> void:
	grid.modulate.a = 1


func _on_btn_jump_add_pressed() -> void:
	if on_btn_added(JUMP_PRICE):
		jump_added_rms += JUMP_PRICE
		jump_added.set_text("+" + str(jump_added_rms))


func _on_btn_jump_del_pressed() -> void:
	if on_btn_del(JUMP_PRICE) and jump_added_rms > 0:
		jump_added_rms -= JUMP_PRICE
		var _char = "+" if jump_added_rms > 0 else ""
		jump_added.set_text(_char + str(jump_added_rms))


func _on_btn_jump_add_released() -> void:
	grid.modulate.a = 1


func _on_btn_jump_del_released() -> void:
	grid.modulate.a = 1


func _on_btn_no_pressed() -> void:
	btn_no.modulate.a = 0.1
	
	selected_rms = 0
	power_added_rms = 0
	speed_added_rms = 0
	jump_added_rms = 0

	if is_visible(): 
		yield(get_tree().create_timer(0.4), "timeout")
		hide()


func _on_btn_yes_pressed():
	btn_yes.modulate.a = 0.1
		
	if is_visible(): 
		# Upgrade bike's parameters
		if PlayerData.rms < selected_rms: 
			field_log.error("Need to more Rms!")
		elif selected_rms > 0:
			var empty_bike: Node = load("res://Game/Bike/EmptyBike.gd").new()
			empty_bike.upgrade_bike_parameters(
				selected_rms,
				power_value, power_added_rms,
				speed_value, speed_added_rms,
				jump_value, jump_added_rms
			)
			
			field_log.success("Bike's parameters was upgraded successful!")
		
		yield(get_tree().create_timer(.4), "timeout")
		get_tree().reload_current_scene()


func open(player_bike: Node) -> void:
	popup()  # show()

	if player_bike:
		title += player_bike.title
		find_node("Title").set_text(title)

		power_value.set_text(str(player_bike.max_power))
		speed_value.set_text(str(player_bike.max_speed))
		jump_value.set_text(str(player_bike.max_height_jump))
		
	#popup_centered()


# func set_rm_counter() -> void:	rm_counter.set_text(str(PlayerData.rms) + " / " + str(selected_rms))


func on_btn_added(price) -> bool:
	field_log.clear()
	grid.modulate.a = 0.5
	
	if PlayerData.rms > selected_rms + price:
		selected_rms += price
		# set_rm_counter()
		return true
	else:
		field_log.error("Have not enough the Rms")
		return false
		

func on_btn_del(price) -> bool:
	field_log.clear()
	grid.modulate.a = 0.5
	
	if selected_rms - price >= 0:
		selected_rms -= price
		# set_rm_counter()
		return true

	return false
