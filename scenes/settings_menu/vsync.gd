extends OptionButton

func _ready():
	var mode = DisplayServer.window_get_vsync_mode()
	match mode:
		DisplayServer.VSYNC_ENABLED:
			select(0)
		DisplayServer.VSYNC_DISABLED:
			select(1)
		DisplayServer.VSYNC_ADAPTIVE:
			select(2)
		_:
			select(0)
	
	
	item_selected.connect(_on_vsync_options_item_selected)


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
