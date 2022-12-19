extends Node

signal message_entered(message)


@onready var _duplicate_output_to_godot = ProjectSettings.get("application/config/duplicate_logger_output_to_debugger")
@onready var _history : History
var _string_id := 1

# Use in your console output
# color (html)
func _format_output(value : String, color : String = '') -> String:
	var message = str(_string_id) + ": "
	message = '[color=%s]' + value + '[/color]'
	message = message % color
#	_history.put_line(value)
	return message


# Use in godot debugger output
func _raw_output(value : String) -> String:
	return str(_string_id) + ": " + value



func _format_warning(value : String) -> String:
	var r = _format_output(value, '#FFFF00') # yellow
	return r


func _format_error(value : String) -> String:
	var r = _format_output(value, '#FF0000') # red
	return r


func debug_log(value, message_type = MESSAGE_TYPE.REGULAR, override_color : String = '') -> void:
	if not typeof(value) == TYPE_STRING:
		value = str(value)
	
	var console_output = ''
	
	match message_type:
		MESSAGE_TYPE.WARNING:
			console_output = _format_warning(value)
		MESSAGE_TYPE.ERROR:
			console_output = _format_error(value)
		MESSAGE_TYPE.REGULAR:
#			console_output = _format_output(value)
			console_output = _format_output(value)
	
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
