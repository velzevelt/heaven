extends RichTextLabel

#@export var greeting_text = "type [color=aqua]help[/color] to get general manual, type [color=aqua]q[/color] or press [color=aqua]~[/color] to close console"

func _ready() -> void:
	text = ''
	Logger.message_entered.connect( _on_log )

func _on_log(message) -> void:
	text += message + "\n"

#func _on_log(var output : String) -> void:
#	if bbcode_text == greeting_text:
#		bbcode_text = ""
#
#	bbcode_text += output
#	bbcode_text += "\n"



