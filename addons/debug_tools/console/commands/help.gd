extends ConsoleCommand


func execute():
	
	if has_arguments() and creator.has_command(arguments[0]):
		var command = creator.get_command(arguments[0])
		var command_instance = creator.create_command_object(command)
		
		if command_instance.has_method('show_help'):
			command_instance.show_help()
	

func show_help():
	Logger.debug_log('test')
