extends Label
@tool

func _process(delta):
	var fps = Engine.get_frames_per_second()
	text = str(fps)
