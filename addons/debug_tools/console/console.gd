class_name Console
extends VBoxContainer

@export var commands_directory_path: String = "res://addons/debug_tools/console/commands"

var command_list = {
	
	"q": "quit",
	"quit": "quit",
	"exit": "quit",
	
	"h": "help",
	"help": "help",
	
	"show_commands": "show_commands",
	"ls": "show_commands",
	
	"unpause": "unpause"
	
}

func get_command_list() -> Dictionary:
	return command_list


func execute_command(command: ConsoleCommand, arguments: Array[String]) -> void:
	command._initialize(self, arguments)
	command.execute()
	command.call_deferred('free')


func create_command_object(command: String) -> ConsoleCommand:
	var path_to_command = commands_directory_path + "/" + command + ".gd"
	
	if not ResourceLoader.exists(path_to_command):
		Logger.debug_log(command + " command not found at path " + path_to_command, MESSAGE_TYPE.ERROR)
		return ConsoleCommand.new() # NULL
	
	var command_class = load(path_to_command)
	command_class = command_class.new()
	return command_class


func has_command(command: String):
	return command_list.has(command)

func get_command(command: String):
	return command_list.get(command)

func _on_input_command_entered(command, arguments):
	if has_command(command):
		var command_instance = create_command_object(get_command(command))
		execute_command(command_instance, arguments)
	else:
		Logger.debug_log(command + " invalid command", MESSAGE_TYPE.ERROR)


func _on_debug_layer_visibility_changed():
	visible = owner.visible



