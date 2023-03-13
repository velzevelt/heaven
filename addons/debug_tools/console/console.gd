@tool
class_name Console
extends Node


@export_dir var commands_directory_path: String:
	set(value):
		commands_directory_path = value
		update_configuration_warnings()


func _ready():
	update_configuration_warnings()
	if not Engine.is_editor_hint():
		command_list = load_commands()


func _get_configuration_warnings():
	if commands_directory_path.is_empty():
		return ["Select commands dir"]
	return []

var command_list: PackedStringArray


func load_commands():
	var commands: PackedStringArray = []
	
	if DirAccess.dir_exists_absolute(commands_directory_path):
		commands = DirAccess.get_files_at(commands_directory_path)
	else:
		Logger.debug_log('Commands directory missing', MESSAGE_TYPE.ERROR)
	
	return commands

func get_command_list():
	return command_list


func execute_command(command: String, arguments: PackedStringArray) -> void:
	var command_instance = get_command(command)
	command_instance._initialize(self, arguments)
	command_instance.execute()


func _format_command(command: String) -> String:
	var result = command
	if not result.ends_with(".gd"):
		result += ".gd"
	
	return result


func has_command(command: String) -> bool:
	return command_list.has(_format_command(command))


func get_command(command: String) -> ConsoleCommand:
	command = _format_command(command)
	var result = ConsoleCommand.new()
	var command_path = commands_directory_path + '/' + command
	
	if has_command(command):
		if ResourceLoader.exists(command_path):
			result = load(command_path)
			result = result.new()
		else:
			Logger.debug_log(command_path, MESSAGE_TYPE.ERROR)
	else:
		Logger.debug_log(command + " invalid command", MESSAGE_TYPE.WARNING)
		Logger.debug_log("Use show_commands to see list of available commands")
	
	return result


func _on_input_command_entered(command, arguments):
	execute_command(command, arguments)


func hide():
	if owner.owner is Window:
		owner.owner.hide()
	else:
		owner.hide()

