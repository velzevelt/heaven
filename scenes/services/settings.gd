extends Node

@onready var _root = get_tree().root as Window
@onready var _init_window_mode = _root.mode

func _process(_delta):
	
	if Input.is_action_just_pressed("hide_cursor"):
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE else Input.MOUSE_MODE_VISIBLE
	
	if Input.is_action_just_pressed("toggle_fullscreen"):
		_root.mode = Window.MODE_FULLSCREEN if _root.mode == _init_window_mode else Window.MODE_WINDOWED


func toggle_fullscreen():
	_root.mode = Window.MODE_FULLSCREEN if _root.mode == _init_window_mode else Window.MODE_WINDOWED
