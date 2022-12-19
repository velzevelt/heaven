extends Label

var relative : Vector2 = Vector2()
var drag_position

func _gui_input(event):
#	if event is InputEventMouseMotion:
#		relative = event.relative
		
	if event is InputEventMouseButton:
		if event.pressed:
			drag_position = get_global_mouse_position() - owner.global_position
		else:
			drag_position = null
	
	if event is InputEventMouseMotion and drag_position:
		owner.global_position = get_global_mouse_position() - drag_position
