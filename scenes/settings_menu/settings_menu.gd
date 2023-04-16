extends MenuComponent


func _on_fps_pressed():
	Settings.toggle_fps_counter_visibility()


func _on_vsync_options_item_selected(index):
	match index:
		0:
			Logger.debug_log('V-Sync on')
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		1:
			Logger.debug_log('V-Sync off')
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		2:
			Logger.debug_log('V-Sync adaptive')
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
		_:
			Logger.debug_log('V-Sync on')
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)


func _on_filtering_options_item_selected(index):
	Logger.debug_log('This option cannot be changed in runtime', MESSAGE_TYPE.WARNING)


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
