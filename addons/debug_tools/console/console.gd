extends VBoxContainer


export(String, DIR) var commands_directory_path = "res://"

export(Dictionary) var command_list = {
	
	"open_shop": "open_shop",
	
	"add_money": "add_money",
	"add_experience": "add_experience",
	
	"q": "quit",
	"exit": "quit",
	"quit": "quit",
	"close": "quit",
	
	"h": "help",
	"help": "help",
	
	"show_commands": "show_commands",
	"show_fps": "show_fps_counter",
	
	"pause": "pause",
	"loose": "loose",
	
} setget , get_command_list


func get_command_list() -> Dictionary:
	return command_list

func pause_off() -> void:
	get_tree().paused = false
	var input_label = $InputPanel/InputLabel
	input_label.release_focus()
	input_label.show_greeting_text()


func _on_Console_hide() -> void:
	pause_off()


func _on_InputLabel_command_entered(command, arguments) -> void:
	var command_instance = create_command_object(command)
	execute_command(command_instance, arguments)



func execute_command(var command : ConsoleCommand, var arguments : PoolStringArray) -> void:
	command.initialize(self, arguments)
	command.execute()
	command.call_deferred("free")


func create_command_object(var command : String) -> ConsoleCommand:
	var path_to_command = commands_directory_path + "/" + command + ".gd"
	
	if not ResourceLoader.exists(path_to_command):
		Logger.debug_log("[color=aqua]" + command + "[/color]" + " command not found at path " + "[color=aqua]" + path_to_command + "[/color]", 
		MESSAGE_TYPE.ERROR)
		return ConsoleCommand.new() # NULL
	
	var command_class = load(path_to_command)
	command_class = command_class.new()
	return command_class


