extends VBoxContainer


@export var commands_directory_path : String = "res://"

@export var command_list = {
	
	"q": "quit",
	"exit": "quit",
	"quit": "quit",
	"close": "quit",
	
	"h": "help",
	"help": "help",
	
	"show_commands": "show_commands",
	
	
} :
	set(value):
	
	get = get_command_list() 
	
#	setget , get_command_list


func get_command_list() -> Dictionary:
	return command_list


func _on_InputLabel_command_entered(command, arguments) -> void:
	var command_instance = create_command_object(command)
	execute_command(command_instance, arguments)



func execute_command(command : ConsoleCommand, arguments : PoolStringArray) -> void:
	command.initialize(self, arguments)
	command.execute()
	command.call_deferred("free")


func create_command_object(command : String) -> ConsoleCommand:
	var path_to_command = commands_directory_path + "/" + command + ".gd"
	
	if not ResourceLoader.exists(path_to_command):
		Logger.debug_log("[color=aqua]" + command + "[/color]" + " command not found at path " + "[color=aqua]" + path_to_command + "[/color]", 
		MESSAGE_TYPE.ERROR)
		return ConsoleCommand.new() # NULL
	
	var command_class = load(path_to_command)
	command_class = command_class.new()
	return command_class


