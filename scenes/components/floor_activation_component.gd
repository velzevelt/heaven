## Used for activate any current_floor objects below player or smth
class_name FloorActivationComponent
extends Node

@export var body: CharacterBody3D
var _prev_floor = null
var current_floor = null


func _physics_process(_delta):
	if not Engine.is_editor_hint():
		if body.is_on_floor_only():
			@warning_ignore("shadowed_global_identifier")
			current_floor = body.get_last_slide_collision()
			if is_instance_valid(current_floor):
				current_floor = current_floor.get_collider()
				if current_floor != _prev_floor:
#					print("IN STRICT")
					if current_floor.has_signal('object_entered_strict') or current_floor.has_user_signal('object_entered_strict'):
						current_floor.emit_signal('object_entered_strict', body)
					if current_floor.has_signal('object_entered') or current_floor.has_user_signal('object_entered'):
						current_floor.emit_signal('object_entered', body)
				_prev_floor = current_floor
		elif body.is_on_floor():
			@warning_ignore("shadowed_global_identifier")
			current_floor = body.get_last_slide_collision()
			if is_instance_valid(current_floor):
				current_floor = current_floor.get_collider()
				if current_floor != _prev_floor:
#					print("IN")
					if current_floor.has_signal('object_entered') or current_floor.has_user_signal('object_entered'):
						current_floor.emit_signal('object_entered', body)
				_prev_floor = current_floor
		else:
			exit_floor()


func exit_floor():
	if is_instance_valid(_prev_floor):
		if _prev_floor.has_signal('object_exited') or _prev_floor.has_user_signal('object_exited'):
			_prev_floor.emit_signal('object_exited', body)
		_prev_floor = null
