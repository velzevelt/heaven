extends ConsoleCommand


var command_list : Dictionary
var general_help_message : String = "type show_commands to see available commands " \
+ "type help [command_name] to see details about command e.g. " \
+ "help add_money"


func _init() -> void:
	command_description = general_help_message


func execute() -> void:
	command_list = creator.get_command_list()
	var commands = command_list.keys()
	
	
	if arguments.size() > 0 and arguments[0] in commands:
		var command = command_list.get(arguments[0])
		command = creator.create_command_object(command)
		command_description = command.command_description
	
	
	Logger.debug_log(command_description)
	

