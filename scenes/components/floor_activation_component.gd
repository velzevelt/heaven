## Used for activate any floor objects below player or smth
class_name FloorActivationComponent
extends Node

@export var body: CharacterBody3D
var _prev_floor = null

func _ready():
	update_configuration_warnings()

func _notification(what):
	match what:
		NOTIFICATION_PARENTED:
			update_configuration_warnings()
		NOTIFICATION_UNPARENTED:
			update_configuration_warnings()




func _physics_process(_delta):
	if not Engine.is_editor_hint():
		if body.is_on_floor_only():
			var floor = body.get_last_slide_collision()
			if is_instance_valid(floor):
				floor = floor.get_collider()
				if floor != _prev_floor:
					print("IN STRICT")
					if floor.has_signal('object_entered_strict') or floor.has_user_signal('object_entered_strict'):
						floor.emit_signal('object_entered_strict', body)
					if floor.has_signal('object_entered') or floor.has_user_signal('object_entered'):
						floor.emit_signal('object_entered', body)
				_prev_floor = floor
		elif body.is_on_floor():
			var floor = body.get_last_slide_collision()
			if is_instance_valid(floor):
				floor = floor.get_collider()
				if floor != _prev_floor:
					print("IN")
					if floor.has_signal('object_entered') or floor.has_user_signal('object_entered'):
						floor.emit_signal('object_entered', body)
				_prev_floor = floor
		else:
			if is_instance_valid(_prev_floor):
				print("OUT")
				if _prev_floor.has_signal('object_entered') or _prev_floor.has_user_signal('object_entered'):
					_prev_floor.emit_signal('object_exited', body)
				_prev_floor = null


#if body.is_on_floor():
#			var floor = body.get_last_slide_collision()
#			if is_instance_valid(floor):
#				floor = floor.get_collider()
#				if floor != _prev_floor:
#					print("IN")
#					if floor.has_signal('object_entered') or floor.has_user_signal('object_entered'):
#						floor.emit_signal('object_entered', body)
#				_prev_floor = floor



#		if not body.is_on_floor():
#			if is_instance_valid(_prev_floor):
#				print("OUT")
#				if _prev_floor.has_signal('object_entered') or _prev_floor.has_user_signal('object_entered'):
#					_prev_floor.emit_signal('object_exited', body)
#				_prev_floor = null
#		else:
#			var floor = body.get_last_slide_collision()
#			if is_instance_valid(floor):
#				floor = floor.get_collider()
#				if floor != _prev_floor:
#					print("IN")
#					if body.is_on_floor():
#						if floor.has_signal('object_entered') or floor.has_user_signal('object_entered'):
#							floor.emit_signal('object_entered', body)
#					elif body.is_on_floor_only():
#						if floor.has_signal('object_entered_strict') or floor.has_user_signal('object_entered_strict'):
#							floor.emit_signal('object_entered_strict', body)
#
#				_prev_floor = floor
