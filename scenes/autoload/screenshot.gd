extends Node

const DIR_PATH = 'user://screenshots/'


func clear_screenshot_dir() -> void:
	if DirAccess.remove_absolute(DIR_PATH) == OK:
		Logger.debug_log('Screenshot directory was successfully deleted')
	else:
		Logger.debug_log('Cannot delete screenshot directory!', MESSAGE_TYPE.ERROR)
	


func take_screenshot() -> void:
	if DirAccess.open(DIR_PATH) == null:
		var dir = DirAccess.make_dir_absolute(DIR_PATH)
		if dir != OK:
			Logger.debug_log('Cannot create screenshot directory', MESSAGE_TYPE.ERROR)
			return
	
	# WARN: It is unsafe, image can be overriden with this path
	var postfix = 'image' + str(Time.get_ticks_usec()) + ".png"
	
	var screenshot = get_tree().root.get_texture()
	var screenshot_path = DIR_PATH + postfix
	screenshot.get_image().save_png(screenshot_path)
	Logger.debug_log('Screenshot saved %s' % ProjectSettings.globalize_path(screenshot_path))


func _input(event):
	if Input.is_action_just_pressed('take_screenshot'):
		take_screenshot()
