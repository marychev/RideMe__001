extends Area2D


func _on_Start_body_entered(body: Node) -> void:
	var todo = "\r\nTodo: \n" +\
		"O. Need to define that it is the Finish, no Start.\n" +\
		"1. Added the position of road collision instead player.\n" +\
		"2. Show to the Finish screne `title` and so one.\n"
	print(todo)
	
	if body.name == 'Player':
		body.die(true)
