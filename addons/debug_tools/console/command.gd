class_name ConsoleCommand
extends Object

var creator
var arguments : Array[String]
var command_description : String = "help_message"


func initialize(_creator : Object, _arguments : Array[String]) -> void:
	creator = _creator
	arguments = _arguments


func execute() -> void:
	pass
