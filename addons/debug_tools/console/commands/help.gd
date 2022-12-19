extends ConsoleCommand


var command_list : Dictionary
var general_help_message : String = "type [color=aqua]show_commands[/color] to see available commands " \
+ "type [color=aqua]help [command_name][/color] to see details about command e.g. " \
+ "[color=aqua]help add_money[/color]"


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
	

