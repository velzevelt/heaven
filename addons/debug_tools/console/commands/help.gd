extends ConsoleCommand


func execute():
	super()
	if has_arguments() and creator.has_command(arguments[0]):
		var command = creator.get_command(arguments[0])
		if command.has_method('show_help'):
			command.show_help()
		
	else:
		show_help()


func show_help():
	var message = 'Use help [command_name] or [command_name] --help to see help message ' \
	+ 'Use [command_name] --usage to see see command usage ' \
	+ 'Use show_commands to see available commands'
	
	Logger.debug_log(message)
