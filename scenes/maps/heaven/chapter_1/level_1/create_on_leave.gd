## create_node will be deleted at ready and created when player leaves platform
@tool
class_name CreateOnLeave
extends PlatformComponent

@export var create_node: Node
@export var create_immediately := true:
	set(value):
		create_immediately = value
		notify_property_list_changed()
		
var create_delay := 0.0
var _init_parent

func _get_property_list():
	var property_usage = PROPERTY_USAGE_NO_EDITOR
	if not create_immediately:
		property_usage = PROPERTY_USAGE_DEFAULT
	
	var properties = []
	properties.append(
		{
			'name': 'create_delay',
			'type': TYPE_FLOAT,
			'usage': property_usage,
		}
	)
	return properties

func _ready():
	super()
	if not Engine.is_editor_hint():
		_init_parent = create_node.get_parent()
		var temp = create_node.duplicate()
		create_node.queue_free()
		create_node = temp

func _on_object_exited(player):
	if not create_immediately:
		await get_tree().create_timer(create_delay).timeout
	
	_init_parent.call_deferred('add_child', create_node)
	call_deferred('queue_free')
