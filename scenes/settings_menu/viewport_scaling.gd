extends OptionButton

func _ready():
	var mode = get_tree().root.content_scale_mode
	match mode:
		Window.CONTENT_SCALE_MODE_CANVAS_ITEMS:
			select(0)
		Window.CONTENT_SCALE_MODE_VIEWPORT:
			select(1)
	
	item_selected.connect(_on_viewport_scaling_options_item_selected)


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
