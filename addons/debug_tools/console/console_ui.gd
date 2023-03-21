@tool
extends VBoxContainer


func _ready():
	update_configuration_warnings()
	self.visible = false


func _notification(what):
	match what:
		NOTIFICATION_VISIBILITY_CHANGED:
			update_configuration_warnings()


func _get_configuration_warnings():
	if self.visible:
		return ['This node acts like popup window, will hide at ready']
	return []


func _process(delta):
	if not Engine.is_editor_hint():
		if Input.is_action_just_pressed('show_console'):
			self.visible = !self.visible
