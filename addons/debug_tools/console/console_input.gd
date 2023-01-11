extends LineEdit

signal command_entered(command, arguments)

func _on_text_submitted(submitted_text: String):
	text = ''
	submitted_text = submitted_text.trim_prefix(" ")
	submitted_text = submitted_text.trim_suffix(" ")
	var line = submitted_text.split(" ")
	var command = line[0]
	
	var arguments: Array[String] = []
	for i in range(1, line.size()):
		arguments.append(line[i])
	
	command_entered.emit(command, arguments)



