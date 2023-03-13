extends ScrollContainer
#
#
#var is_grabbed = false
#
#
#func _process(delta):
#	v *= 0.9
#	if v.length() <= just_stop_under: v = Vector2(0,0)
#	$origin.rect_position += v
#
#
#func _gui_input(event):
#
#	if event is InputEventMouseButton:
#		match event.button_index:
#			BUTTON_MIDDLE:  is_grabbed = event.pressed
#
#	if event is InputEventMouseButton:
#		match event.button_index:
#			BUTTON_WHEEL_DOWN:  v.y += multi
#			BUTTON_WHEEL_UP:    v.y -= multi
#			BUTTON_WHEEL_RIGHT: v.x += multi
#			BUTTON_WHEEL_LEFT:  v.x -= multi
