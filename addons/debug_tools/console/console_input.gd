extends LineEdit

signal command_entered(command, arguments)

var command_history: PackedStringArray
var _command_id := 0

func _on_text_submitted(submitted_text: String):
	clear()
	submitted_text = submitted_text.trim_prefix(" ")
	submitted_text = submitted_text.trim_suffix(" ")
	
	command_history.append(submitted_text)
	_command_id = command_history.size()
	
	var line = submitted_text.split(" ")
	var command = line[0]
	
	line.remove_at(0) # 0 - command name, greater - arguments
	var arguments = line
	
	command_entered.emit(command, arguments)


func _gui_input(event):
	if Input.is_action_just_pressed('ui_up'):
		_on_up()
	if Input.is_action_just_pressed('ui_down'):
		_on_down()


func _on_down():
	if _command_id < command_history.size():
		text = command_history[_command_id]
		_command_id += 1
	else:
		clear()

func _on_up():
	if _command_id - 1 >= 0:
		_command_id -= 1
		text = command_history[_command_id]
	else:
		clear()
