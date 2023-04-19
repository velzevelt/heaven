extends HSlider


func _ready():
	value = ProjectSettings.get_setting("display/mouse_cursor/sensitivity")
	value_changed.connect(Settings.change_mouse_sensitivity)

