class_name ConsoleCommand
extends Object

var creator
var arguments : PoolStringArray
var command_description : String = "help_message"


func initialize(var _creator : Object, var _arguments : PoolStringArray) -> void:
	creator = _creator
	arguments = _arguments


func execute() -> void:
	pass
