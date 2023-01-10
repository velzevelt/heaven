extends ConsoleCommand

# Do not show duplicates
var less = false

func execute() -> void:
	super()
	if not has_arguments():
		var command_list = creator.get_command_list()
		for command in command_list.keys():
			Logger.debug_log(command)
	else:
		var command_list = creator.get_command_list()
		if less:
			var temp = []
			for command in command_list.keys():
				if not command_list.get(command) in temp:
					temp.append(command)
			
			for command in temp:
				Logger.debug_log(command)


func get_supported_params():
	var params = super()
	var new_params = {
		"--less": set_less
	}
	
	params.merge(new_params)
	return params

func set_less():
	self.less = true
