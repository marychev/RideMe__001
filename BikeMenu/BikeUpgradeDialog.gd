extends PopupDialog

signal updated(title)


func open(title) -> void:
	find_node("Title").set_text("Hello")
	popup_centered()
