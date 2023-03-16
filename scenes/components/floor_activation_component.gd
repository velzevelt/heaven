## Used for activate any floor objects below player or smth
class_name FloorActivationComponent
extends Node

@export var body: CharacterBody3D
var _prev_floor = null


func _physics_process(_delta):
	if not Engine.is_editor_hint():
		if body.is_on_floor_only():
			@warning_ignore("shadowed_global_identifier")
			var floor = body.get_last_slide_collision()
			if is_instance_valid(floor):
				floor = floor.get_collider()
				if floor != _prev_floor:
#					print("IN STRICT")
					if floor.has_signal('object_entered_strict') or floor.has_user_signal('object_entered_strict'):
						floor.emit_signal('object_entered_strict', body)
					if floor.has_signal('object_entered') or floor.has_user_signal('object_entered'):
						floor.emit_signal('object_entered', body)
				_prev_floor = floor
		elif body.is_on_floor():
			@warning_ignore("shadowed_global_identifier")
			var floor = body.get_last_slide_collision()
			if is_instance_valid(floor):
				floor = floor.get_collider()
				if floor != _prev_floor:
#					print("IN")
					if floor.has_signal('object_entered') or floor.has_user_signal('object_entered'):
						floor.emit_signal('object_entered', body)
				_prev_floor = floor
		else:
			exit_floor()


func exit_floor():
	if is_instance_valid(_prev_floor):
		if _prev_floor.has_signal('object_exited') or _prev_floor.has_user_signal('object_exited'):
			_prev_floor.emit_signal('object_exited', body)
		_prev_floor = null
