extends ConsoleCommand


func execute() -> void:
	var command_list = creator.get_command_list()
	var commands = command_list.keys()
	
	if has_arguments() and arguments[0] in commands:
		var command = command_list.get(arguments[0])
		creator.
	
