extends CanvasLayer


func _input(event):
	if Input.is_action_just_pressed('show_debug'):
		self.visible = !self.visible
		if self.visible:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _ready():
	if not OS.is_debug_build():
		self.visible = false
