extends Button

signal double_clicked
signal remapped

@export var linked_action := ''
@onready var remap_menu: Control = $%RemapMenu

var listen_event := false
var new_event

func _ready():
	if InputMap.has_action(linked_action):
		text = get_action_key()
	else:
		Logger.debug_log(linked_action + " action not found", MESSAGE_TYPE.WARNING)
	
	double_clicked.connect(_remap_action)
	remapped.connect(_update_text)
	remapped.connect(func(): print(InputMap.action_get_events(linked_action)))


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
	remapped.emit()

func _update_text():
	text = get_action_key()


func _gui_input(event):
	if event is InputEventMouseButton:
		if event.double_click:
			listen_event = true
			double_clicked.emit()


func _input(event):
	if listen_event:
		if event is InputEventKey or event is InputEventMouseButton:
			if event.pressed:
				new_event = event
				listen_event = false
