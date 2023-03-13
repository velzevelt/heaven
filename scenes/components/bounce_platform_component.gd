@tool
class_name BouncePlatformComponent
extends PlatformComponent

@export var jump_force := 10.0
@export var trampoline_mode := false
@export var max_height := 25.0

func _on_object_entered(body):
	if body.has_node('PlayerMoveComponent'):
		if trampoline_mode and body.has_node('VelocityComponent'):
			var new_force = clampf(body.get_node('VelocityComponent').last_velocity.y / 2 + jump_force, 0.0, max_height)
			body.get_node('PlayerMoveComponent').jump(new_force)
		else:
			body.get_node('PlayerMoveComponent').jump(jump_force)
	else:
		Logger.debug_log('No MoveComponent found, skipping bounce', MESSAGE_TYPE.WARNING)
