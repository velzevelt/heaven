extends ConsoleCommand

func execute() -> void:
	super()
	if not has_arguments():
		var command_list = creator.get_command_list()
		for command in command_list:
			Logger.debug_log(command)
