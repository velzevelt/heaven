extends Button

@export var linked_action := ''
@onready var remap_menu: Control = $%RemapMenu

var waiting_message = "WAITING_FOR_INPUT"
var listen_event := false
var new_event

func _ready():
	if InputMap.has_action(linked_action):
		text = get_action_key()
	else:
		Logger.debug_log(linked_action + " action not found", MESSAGE_TYPE.WARNING)
	


func get_action_key() -> String:
	var actions = InputMap.action_get_events(linked_action)
	var out = ''
	
	if actions.size() > 1:
		for action in actions:
			out += action.as_text() + ", "
		out = out.rstrip(", ")
	elif actions.size() == 1:
		out = actions[0].as_text()
	
	return out


func _remap_action():
	InputMap.action_erase_events(linked_action)
	InputMap.action_add_event(linked_action, new_event)


func _update_text():
	text = get_action_key()


func _gui_input(event):
	if listen_event:
		return
	
	if event is InputEventMouseButton:
		if event.double_click:
			text = tr(waiting_message)
			await get_tree().create_timer(0.1).timeout
			listen_event = true


func _input(event):
	if not listen_event:
		return

	if event is InputEventKey:
		if event.pressed:
			new_event = event
			_remap_action()
			_update_text()
			listen_event = false
			
	elif event is InputEventMouseButton:
		if not event.double_click:
			new_event = event
			_remap_action()
			_update_text()
			listen_event = false
	
	
