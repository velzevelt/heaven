extends Node
class_name History

var history : Array

func get_line(line_id : int) -> String:
	line_id -= 1
	return ''

func put_line(message : String) -> void:
	history.append(message)
