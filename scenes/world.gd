extends Node3D

var captured = false
@onready var root = get_tree().root as Window
@onready var init_window_mode = root.mode

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("left_click"):
			captured = !captured
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if captured else Input.MOUSE_MODE_VISIBLE
	
	if Input.is_action_just_pressed("toggle_fullscreen"):
		root.mode = Window.MODE_FULLSCREEN if root.mode == init_window_mode else Window.MODE_WINDOWED
