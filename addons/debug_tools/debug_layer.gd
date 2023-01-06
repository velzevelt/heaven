extends CanvasLayer

@onready var console = $ConsoleWindow as Window

func _input(event):
	if Input.is_action_just_pressed('show_debug'):
		self.visible = !self.visible
		console.visible = self.visible
	if Input.is_action_just_pressed('show_console'):
		console.reset_position()
		console.visible = !console.visible
	

func _ready():
	if not OS.is_debug_build():
		self.visible = false
