@tool
class_name PlatformComponent 
extends Node

@export var platform_body: PlatformBody


func _ready():
	update_configuration_warnings()
	
	if not Engine.is_editor_hint():
		_initialize()


func _initialize():
	platform_body.connect('object_entered', _on_object_entered)
	platform_body.connect('object_exited', _on_object_exited)
	


@warning_ignore("unused_parameter")
func _on_object_entered(obj):
	pass

@warning_ignore("unused_parameter")
func _on_object_exited(obj):
	pass


func _notification(what):
	match what:
		NOTIFICATION_PARENTED:
			update_configuration_warnings()
		NOTIFICATION_UNPARENTED:
			update_configuration_warnings()
