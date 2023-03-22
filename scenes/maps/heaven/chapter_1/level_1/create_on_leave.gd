## create_node will be deleted at ready and created when player leaves platform
@tool
class_name CreateOnLeave
extends PlatformComponent

@export var create_node: PackedScene
@export var new_parent: Node

@export var create_delay := 0.8

func _on_object_exited(player):
	if player.is_in_group('player') and create_node != null:
		await get_tree().create_timer(create_delay).timeout
		new_parent.call_deferred('add_child', create_node.instantiate())
