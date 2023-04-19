extends Label


func _ready():
	var platform = OS.get_name()
	text = tr(text)
	text += ' ' + platform

