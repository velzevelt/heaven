extends Button


func _ready():
	pressed.connect(Settings.toggle_fps_counter_visibility)
