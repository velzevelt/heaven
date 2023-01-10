class_name ConsoleCommand
extends Object

var creator: Console
var arguments: Array[String]


func _initialize(creator: Console, arguments: Array[String]) -> void:
	self.creator = creator
	self.arguments = arguments

func execute() -> void:
	if has_arguments():
		var argument = arguments[0]
		

func show_help() -> void:
	Logger.debug_log("This command doesn't have help message")

func has_arguments() -> bool:
	return (arguments.size() > 0)

func get_supported_params() -> Array[String]:
	return [
		'--help',
		'-h'
	]
