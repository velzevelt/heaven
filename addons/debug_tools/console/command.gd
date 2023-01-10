class_name ConsoleCommand
extends Object

var creator : Console
var arguments : Array[String]

func _initialize(creator : Object, arguments : Array[String]) -> void:
	creator = creator
	arguments = arguments

func execute() -> void:
	pass

func show_help() -> void:
	Logger.debug_log("This command doesn't have help message")

func show_usage() -> void:
	Logger.debug_log("This command doesn't have usage message")

func has_arguments() -> bool:
	return (arguments.size() > 0)
