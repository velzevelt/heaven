extends LineEdit

signal command_entered(command, arguments)

@export var command_color := Color(0.378984, 0.657019, 0.902344)

@onready var _command_list = owner.command_list


#func _ready() -> void:
#	_initialize()
#
#
#func _initialize() -> void:
#	for command in _command_list.keys():
#		add_keyword_color(command, command_color)
#
#
#func _on_InputLabel_text_changed() -> void:
#	if "\n" in text:
#		var clear_text = text.strip_escapes()
#		var line = []
#		line = clear_text.split(" ")
#
#		var function = line[0]
#
#		if _command_list.has(function):
#			function = _command_list.get(function)
#		else:
#			Logger.debug_log(function + " command not found", MESSAGE_TYPE.WARNING)
#			text = ""
#			return
#
#		var arguments = []
#		for i in range(1, line.size()):
#			arguments.append(line[i])
#
#		text = ""
#		emit_signal("command_entered", function, arguments)
#
#
#func _on_InputLabel_focus_entered() -> void:
#	text = ""
#	get_tree().paused = true
#
#
#func _on_InputLabel_visibility_changed() -> void:
#	show_greeting_text()
#
#func show_greeting_text() -> void:
#	text = greeting_text
