@tool
extends Label

func _process(_delta):
	if visible:
		var fps = Engine.get_frames_per_second()
		text = str(fps)
