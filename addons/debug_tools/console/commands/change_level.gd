extends ConsoleCommand

func execute():
	super()
	if has_arguments() and not is_param(arguments[0]):
		var err = SceneLoader.change_scene(arguments[0])
		if err != OK:
			get_suggesions(arguments[0])


func get_suggesions(scene_name):
	var message = ''
	for scene in SceneLoader._scenes:
		if scene_name in scene:
			message += "Suggestion: %s\n" % scene
	Logger.debug_log(message)
