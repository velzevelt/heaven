extends ConsoleCommand


func execute():
	if has_arguments() and creator.has_command(arguments[0]):
		var command = creator.get_command(arguments[0])
		var command_instance = creator.create_command_object(command)
		
		if command_instance.has_method('show_help'):
			command_instance.show_help()
	else:
		show_help()

func show_help():
	var message = 'Type help [command_name] to see help message'
	'Type ls to see available commands'
	Logger.debug_log(message)
