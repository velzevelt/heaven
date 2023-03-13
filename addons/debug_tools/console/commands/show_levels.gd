extends ConsoleCommand


func execute():
	super()
	if not has_arguments():
		for level in SceneLoader._scenes:
			Logger.debug_log(level)
