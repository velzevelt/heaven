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
				if body.get_node('PlayerMoveComponent').velocity_component != null:
					var move_component = body.get_node('PlayerMoveComponent') as PlayerMoveComponent
					var old_velocity = move_component.velocity_component.jump_velocity
					var new_velocity = clampf(move_component.velocity_component.last_velocity.y / 2 + jump_force, 0.0, max_height)
					move_component.velocity_component.jump_velocity = new_velocity
					move_component.wish_jump = true
					await get_tree().physics_frame
					await get_tree().physics_frame
					move_component.velocity_component.jump_velocity = old_velocity
				else:
					Logger.debug_log('No VelocityComponent found, trampoline does not work!', MESSAGE_TYPE.WARNING)
					foo(body)
			else:
				foo(body)
		else:
			Logger.debug_log('No MoveComponent found, skipping bounce', MESSAGE_TYPE.WARNING)

func foo(body):
	var move_component = body.get_node('PlayerMoveComponent') as PlayerMoveComponent
	var old_velocity = move_component.velocity_component.jump_velocity
	var new_velocity = jump_force
	move_component.velocity_component.jump_velocity = new_velocity
	move_component.wish_jump = true
	await get_tree().physics_frame
	await get_tree().physics_frame
	move_component.velocity_component.jump_velocity = old_velocity
