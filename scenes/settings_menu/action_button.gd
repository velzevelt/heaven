extends Button

@export var linked_action := ''
@onready var remap_menu: Control = $%RemapMenu

func _ready():
	pressed.connect(_on_pressed)
	
	if InputMap.has_action(linked_action):
		text = get_action_key()
	else:
		Logger.debug_log(linked_action + " action not found", MESSAGE_TYPE.WARNING)
	
	


func get_action_key() -> String:
	var actions = InputMap.action_get_events(linked_action)
	if actions.size() > 1:
		var out := ''
		for action in actions:
			out += action.as_text() + ", "
		out = out.rstrip(", ")
		actions = out
	else:
		actions = actions[0].as_text()
	
	
	return actions

func _on_pressed():
	print(1)
