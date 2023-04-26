extends Node

const DIR_PATH = 'user://screenshots/'


func delete_screenshots() -> void:
	var dir = DirAccess.open(DIR_PATH)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while not file_name.is_empty():
			if dir.current_is_dir():
				continue
			else:
				if dir.remove(file_name) == OK:
					Logger.debug_log(file_name + " screenshot deleted")
				else:
					Logger.debug_log(file_name + " delete operation failed", MESSAGE_TYPE.ERROR)
				
			
			file_name = dir.get_next()
	else:
		Logger.debug_log('Screenshot delete skipped')
	


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
	if screenshot.get_image().save_png(screenshot_path) != OK:
		if screenshot.get_image().save_png(screenshot_path + randi()) != OK:
			Logger.debug_log('Cannot save image', MESSAGE_TYPE.ERROR)
	
	Logger.debug_log('Screenshot saved %s' % ProjectSettings.globalize_path(screenshot_path))


func _input(event):
	if Input.is_action_just_pressed('take_screenshot'):
		take_screenshot()
	
	if Input.is_action_just_pressed('delete_screenshots'):
		delete_screenshots()
