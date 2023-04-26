extends Button

signal double_clicked

@export var linked_action := ''
@onready var remap_menu: Control = $%RemapMenu

var listen_event := false

func _ready():
	if InputMap.has_action(linked_action):
		text = get_action_key()
	else:
		Logger.debug_log(linked_action + " action not found", MESSAGE_TYPE.WARNING)
	
#	double_clicked.connect(remap_action)




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


func _gui_input(event):
	if event is InputEventMouseButton:
		if event.double_click:
			double_clicked.emit()
			
			await get_tree().physics_frame
			listen_event = true

func _input(event):
	if listen_event:
		if event is InputEventKey or event is InputEventMouseButton:
			if event.pressed:
				print(event.as_text())
