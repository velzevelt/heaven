## create_node will be deleted at ready and created when player leaves platform
@tool
class_name CreateOnLeave
extends PlatformComponent

@export_enum("PackedScene", "Node") var create_node_type = "PackedScene":
	set(value):
		create_node_type = value
		notify_property_list_changed()


func _get_property_list():
	var properties = []
	
	match create_node_type:
		"PackedScene":
			properties.append({
				'name': 'create_node',
				'type': PackedScene,
				'usage': PROPERTY_USAGE_DEFAULT
			})
		"Node":
			properties.append({
				'name': 'create_node',
				'type': Node,
				'usage': PROPERTY_USAGE_DEFAULT,
				'hint_type': PROPERTY_HINT_NODE_TYPE
			})

	return properties

@export var new_parent: Node

@export var create_delay := 0.4

func _on_object_exited(player):
	if player.is_in_group('player'):
		await get_tree().create_timer(create_delay).timeout
		pass
