extends ConsoleCommand

func execute() -> void:
	var command_list = creator.get_command_list()
	for command in command_list.keys():
		Logger.debug_log(command)
