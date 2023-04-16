@tool
class_name FPSCounter
extends Label

func _ready():
	if not OS.is_debug_build():
		visible = false

func _process(_delta):
	if visible:
		var fps = Engine.get_frames_per_second()
		text = str(fps)
	
	if not Engine.is_editor_hint():
		if Input.is_action_just_pressed('show_debug'):
			visible = DebugLayer.visible
