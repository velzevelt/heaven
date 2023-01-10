extends ConsoleCommand


func execute():
	super()
	if not has_arguments():
		creator.hide()

func get_supported_params() -> Dictionary:
	var params = super()
	return params


func show_help():
	Logger.debug_log("Close this window")
