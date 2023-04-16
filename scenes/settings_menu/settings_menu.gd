extends MenuComponent


func _on_fps_pressed():
	Settings.toggle_fps_counter_visibility()


func _on_viewport_scaling_options_item_selected(index):
	match index:
		0:
			Logger.debug_log('Viewport scale mode: canvas_items')
			get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
		1:
			Logger.debug_log('Viewport scale mode: viewport')
			get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
		_:
			Logger.debug_log('Viewport scale mode: canvas_items')
			get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS


func _on_language_options_item_selected(index):
	pass # Replace with function body.
