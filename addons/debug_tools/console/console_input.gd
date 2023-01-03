extends LineEdit

signal command_entered(command, arguments)

@export var command_color := Color(0.378984, 0.657019, 0.902344)

@onready var _command_list = owner.command_list


func _on_text_submitted(new_text):
	text = ''
	var line = new_text.split(' ')
	var command = line[0]
	
	if _command_list.has(command):
		command = _command_list.get(command)
	else:
		Logger.debug_log(command + " command not found", MESSAGE_TYPE.ERROR)
		return
	
	var arguments = []
	for i in range(1, line.size()):
		arguments.append(line[i])
	
	emit_signal("command_entered", command, arguments)
