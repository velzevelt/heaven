extends Node

@onready var _root = get_tree().root as Window
@onready var _init_window_mode = _root.mode


func _ready():
	var locale = OS.get_locale_language()
	if locale in TranslationServer.get_loaded_locales():
		TranslationServer.set_locale(locale)
	else:
		Logger.debug_log("%s locale not found using en instead" % locale)


func toggle_cursor_visibility():
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func show_cursor():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func hide_cursor():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func toggle_fullscreen():
	Logger.debug_log('fullscreen toggled')
	_root.mode = Window.MODE_FULLSCREEN if _root.mode == _init_window_mode else _init_window_mode

func enable_fullscreen():
	Logger.debug_log('fullscreen on')
	_root.mode = Window.MODE_FULLSCREEN

func disable_fullscreen():
	Logger.debug_log('fullscreen off')
	_root.mode = _init_window_mode

func _input(_event):
	if Input.is_action_just_pressed('hide_cursor'):
		Settings.toggle_cursor_visibility()
	if Input.is_action_just_pressed('toggle_fullscreen'):
		Settings.toggle_fullscreen()
	
	if _event is InputEventKey:
		var e: InputEventKey = _event as InputEventKey
		if e.is_action_released('reload_scene'):
			SceneLoader.reload_scene()


func toggle_fps_counter_visibility():
	FPSCounterLayer.fps_counter.visible = !FPSCounterLayer.fps_counter.visible


func change_mouse_sensitivity(value):
	ProjectSettings.set_setting("display/mouse_cursor/sensitivity", value)
