extends VBoxContainer


@export var commands_directory_path : String = "res://addons/debug_tools/commands"
@onready var _init_position = position

var command_list = {
	
	"q": "quit",
	"exit": "quit",
	"quit": "quit",
	"close": "quit",
	
	"h": "help",
	"help": "help",
	
	"show_commands": "show_commands",
	
	
} : 
	get: 
		return command_list


func get_command_list() -> Dictionary:
	return self.command_list


func _on_InputLabel_command_entered(command, arguments) -> void:
	var command_instance = create_command_object(command)
	execute_command(command_instance, arguments)



func execute_command(command : ConsoleCommand, arguments : Array[String]) -> void:
	command.initialize(self, arguments)
	command.execute()
	command.call_deferred("free")


func create_command_object(command : String) -> ConsoleCommand:
	var path_to_command = commands_directory_path + "/" + command + ".gd"
	
	if not ResourceLoader.exists(path_to_command):
		Logger.debug_log(command + " command not found at path " + path_to_command, MESSAGE_TYPE.ERROR)
		return ConsoleCommand.new() # NULL
	
	var command_class = load(path_to_command)
	command_class = command_class.new()
	return command_class




func _on_visibility_changed():
	if _init_position:
		position = _init_position
