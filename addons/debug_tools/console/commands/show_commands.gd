extends ConsoleCommand


var help_message : String = "list all commands"

func _init() -> void:
	command_description = help_message


func execute() -> void:
	var command_list = creator.get_command_list()
	for command in command_list.keys():
		Logger.debug_log(command)
