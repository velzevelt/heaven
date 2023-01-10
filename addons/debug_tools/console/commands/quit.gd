extends ConsoleCommand


func execute():
	super()
	if not has_arguments():
		creator.get_tree().quit()
