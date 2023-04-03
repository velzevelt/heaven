@tool
class_name BouncePlatformComponent
extends PlatformComponent

@export var jump_force := 10.0
@export var trampoline_mode := false
@export var max_height := 25.0
@export var enabled := true

func _on_object_entered(body):
	if enabled:
		if body.has_node('PlayerMoveComponent'):
			if trampoline_mode:
				if body.has_node('VelocityComponent'):
					var move_component = body.get_node('PlayerMoveComponent') as PlayerMoveComponent
					var old_velocity = move_component.velocity_component.jump_velocity
					var new_velocity = clampf(move_component.last_velocity.y / 2 + jump_force, 0.0, max_height)
					move_component.velocity_component.jump_velocity = new_velocity
					move_component.queue_jump()
					move_component.velocity_component.jump_velocity = old_velocity
				else:
					Logger.debug_log('No VelocityComponent found, trampoline does not work!', MESSAGE_TYPE.WARNING)
					var move_component = body.get_node('PlayerMoveComponent') as PlayerMoveComponent
					var old_velocity = move_component.velocity_component.jump_velocity
					var new_velocity = move_component.velocity_component.jump_velocity + jump_force
					move_component.velocity_component.jump_velocity = new_velocity
					move_component.queue_jump()
					move_component.velocity_component.jump_velocity = old_velocity
			else:
				var move_component = body.get_node('PlayerMoveComponent') as PlayerMoveComponent
				var old_velocity = move_component.velocity_component.jump_velocity
				var new_velocity = move_component.velocity_component.jump_velocity + jump_force
				move_component.velocity_component.jump_velocity = new_velocity
				move_component.queue_jump()
				move_component.velocity_component.jump_velocity = old_velocity
		else:
			Logger.debug_log('No MoveComponent found, skipping bounce', MESSAGE_TYPE.WARNING)
