extends OptionButton


func _ready():
	match get_tree().root.mode:
		Window.MODE_WINDOWED:
			select(1)
		Window.MODE_FULLSCREEN, Window.MODE_EXCLUSIVE_FULLSCREEN:
			select(0)
		_:
			select(0)
	
	item_selected.connect(_on_item_selected)


func _on_item_selected(index):
	match index:
		0:
			Settings.enable_fullscreen()
		1:
			Settings.disable_fullscreen()
		_:
			Settings.disable_fullscreen()
