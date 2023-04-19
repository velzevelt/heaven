@tool
extends Label

func _ready():
	text = ProjectSettings.get_setting('application/config/version')
	text = text + "-" + OS.get_name().to_lower()
