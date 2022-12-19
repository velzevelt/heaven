extends ConsoleCommand

var help_message : String = "close console"

func _init() -> void:
	command_description = help_message

func execute() -> void:
	if creator.has_method("hide"):
		creator.call("hide")
