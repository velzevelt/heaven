extends CanvasLayer

@onready var draw = $DebugVector3D

func _input(event):
	if Input.is_action_just_pressed('show_debug'):
		self.visible = !self.visible
	
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true


func _ready():
	if not OS.is_debug_build():
		self.visible = false
