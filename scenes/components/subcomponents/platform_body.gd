class_name PlatformBody
extends Node

signal object_entered_strict(obj)
signal object_entered(obj)
signal object_exited(obj)

#@onready var target: Node3D = self


#func _ready():
#	update_configuration_warnings()
#
#	if not target.has_signal('player_entered'):
#		target.add_user_signal('player_entered', [
#			{ "name": "player", "type": TYPE_OBJECT },
#		])
#	if not target.has_signal('player_exited'):
#		target.add_user_signal('player_exited', [
#			{ "name": "player", "type": TYPE_OBJECT },
#		])
#
#	if not Engine.is_editor_hint():
#		call_deferred('free')

#func _notification(what):
#	match what:
#		NOTIFICATION_PARENTED:
#			update_configuration_warnings()
#		NOTIFICATION_UNPARENTED:
#			update_configuration_warnings()
