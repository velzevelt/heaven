extends RichTextLabel

export var greeting_text = "type [color=aqua]help[/color] to get general manual, type [color=aqua]q[/color] or press [color=aqua]~[/color] to close console"

func _ready() -> void:
	Logger.connect("message_entered", self, "_on_log")


func _on_log(var output : String) -> void:
	if bbcode_text == greeting_text:
		bbcode_text = ""
	
	bbcode_text += output
	bbcode_text += "\n"


func _on_ConsoleLabel_visibility_changed() -> void:
	bbcode_text = greeting_text
