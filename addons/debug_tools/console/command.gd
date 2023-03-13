class_name ConsoleCommand
extends Resource

var creator: Console
var arguments


func _initialize(creator: Console, arguments: Array[String]) -> void:
	self.creator = creator
	self.arguments = arguments

func execute() -> void:
	apply_params()


func apply_params():
	if has_arguments():
		var supported_params = get_supported_params()
		for argument in arguments:
			if is_param(argument):
				if supported_params.has(argument):
					supported_params.get(argument).call()
				else:
					show_help()
					break

func show_help() -> void:
	Logger.debug_log("This command doesn't have help message")

func show_usage() -> void:
	Logger.debug_log(get_supported_params().keys())

func has_arguments() -> bool:
	return not arguments.is_empty()


func get_supported_params() -> Dictionary: # name: Callable
	return {
		"--help": show_help,
		"-h": show_help,
		
		"--usage": show_usage,
		"-u": show_usage,
	}


func is_param(value: String) -> bool:
	return value.begins_with("-")
