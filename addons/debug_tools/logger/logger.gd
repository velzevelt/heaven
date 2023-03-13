## This Logger doesn't get errors from Engine, get only user defined errors. 
## Enable File Logging in Project Settings to get full logs.
extends Node

signal message_entered(message)


@onready var _duplicate_output_to_godot = ProjectSettings.get("application/config/duplicate_logger_output_to_debugger")
var _string_id := 1


## Use in your console output
## color (html) e.g. '#FF0000'
func _format_output(value: String, color: String = '') -> String:
	var message = str(_string_id) + ": "
	
	if not color.is_empty():
		message = '[color=%s]' + message
		message += value + '[/color]'
		message = message % color
	else:
		message += value
	
	
	return message


## Use in godot debugger
func _raw_output(value: String) -> String:
	return str(_string_id) + ": " + value


func _format_warning(value: String) -> String:
	var r = _format_output(value, '#FFFF00') # yellow
	return r


func _format_error(value: String) -> String:
	var r = _format_output(value, '#FF0000') # red
	return r


## Use everywhere outside
## override_color (html) e.g. '#FF0000'
func debug_log(value, message_type = MESSAGE_TYPE.REGULAR, override_color: String = '') -> void:
	if not typeof(value) == TYPE_STRING:
		value = str(value)
	
	var console_output = ''
	
	match message_type:
		MESSAGE_TYPE.WARNING:
			console_output = _format_warning(value)
		MESSAGE_TYPE.ERROR:
			console_output = _format_error(value)
		MESSAGE_TYPE.REGULAR:
			console_output = _format_output(value, override_color)
	
	if _duplicate_output_to_godot:
		_print_to_godot(value, message_type)
	
	
	emit_signal("message_entered", console_output)
	_string_id += 1


func _print_to_godot(value, message_type = MESSAGE_TYPE.REGULAR):
	var debugger_output = _raw_output(value)
	
	match message_type:
		MESSAGE_TYPE.WARNING:
			push_warning(debugger_output)
		MESSAGE_TYPE.ERROR:
			push_error(debugger_output)
		MESSAGE_TYPE.REGULAR:
			print(debugger_output)
	
