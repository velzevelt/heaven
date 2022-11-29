extends CanvasLayer

func _input(event):
	if Input.is_action_just_pressed('debug_show'):
		self.visible = !self.visible
		


func _ready():
	if not OS.is_debug_build():
		self.visible = false
