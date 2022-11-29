@tool
extends RichTextLabel

@export var fps_palette : Dictionary = {
	GOOD: Color.GREEN,
	NOT_BAD: Color.ORANGE,
	POOR: Color.RED 
}

const GOOD = 55
const NOT_BAD = 45
const POOR = 30


func _process(delta):
	var fps = Engine.get_frames_per_second()
	var text = "[color=#%s]"
	var color = fps_palette.get(GOOD)
	
	if fps <= POOR:
		color = fps_palette.get(POOR)
	elif fps <= NOT_BAD:
		color = fps_palette.get(NOT_BAD)
	elif fps <= GOOD:
		color = fps_palette.get(GOOD)

	text = text % color.to_html()
	text += str( fps ) 
	
	self.text = text
