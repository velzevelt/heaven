## create_node will be deleted at ready and created when player leaves platform
@tool
class_name EnableOnLeave
extends PlatformComponent

@export var disabled_target: Node


func _on_object_exited(player):
	if player.is_in_group('player'):
#		await get_tree().create_timer(create_delay).timeout
		if not is_instance_valid(disabled_target):
			return
		
		if disabled_target.get('visible') != null:
			disabled_target.visible = true
		
		if disabled_target.get('enabled') != null:
			disabled_target.enabled = true
		else:
			Logger.debug_log('Target node does not have "enabled" property. Not implemented yet?', MESSAGE_TYPE.WARNING)
