extends ConsoleCommand


func execute():
	super()
	if not has_arguments():
		console()

func get_supported_params() -> Dictionary:
	var params = super()
	var new_params = {
		'--game': game,
	}
	params.merge(new_params)
	return params

func game():
	creator.get_tree().quit()

func console():
	creator.hide()
