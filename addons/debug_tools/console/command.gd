class_name ConsoleCommand
extends Object

var creator: Console
var arguments: Array[String]


func _initialize(creator: Console, arguments: Array[String]) -> void:
	self.creator = creator
	self.arguments = arguments

func execute() -> void:
	apply_params()


func apply_params() -> void:
	if has_arguments():
		var supported_params = get_supported_params()
		for argument in arguments:
			if is_param(argument):
				for param in supported_params:
					if argument is param[0]:
						param[1].call()


func show_help() -> void:
	Logger.debug_log("This command doesn't have help message")

func has_arguments() -> bool:
	return not arguments.is_empty()


func get_supported_params() -> Array: #[id][0] -> name [id][1] -> callable
	return [
		["--help", show_help],
		['-h', show_help]
	]

func is_param(value: String) -> bool:
	return value.begins_with("-")
