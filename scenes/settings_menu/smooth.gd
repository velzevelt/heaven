extends OptionButton


func _ready():
	match get_viewport().msaa_3d:
		Viewport.MSAA_DISABLED:
			select(0)
		Viewport.MSAA_2X:
			select(1)
		Viewport.MSAA_4X:
			select(2)
		Viewport.MSAA_8X:
			select(3)
		_:
			select(0)
	
	item_selected.connect(_on_item_selected)


func _on_item_selected(index):
	match index:
		Viewport.MSAA_DISABLED:
			Logger.debug_log('MSAA off')
			get_viewport().msaa_3d = Viewport.MSAA_DISABLED
		Viewport.MSAA_2X:
			Logger.debug_log('MSAA 2x')
			get_viewport().msaa_3d = Viewport.MSAA_2X
		Viewport.MSAA_4X:
			Logger.debug_log('MSAA 4x')
			get_viewport().msaa_3d = Viewport.MSAA_4X
		Viewport.MSAA_8X:
			Logger.debug_log('MSAA 8x')
			get_viewport().msaa_3d = Viewport.MSAA_8X
		_:
			Logger.debug_log('MSAA off')
			get_viewport().msaa_3d = Viewport.MSAA_DISABLED
