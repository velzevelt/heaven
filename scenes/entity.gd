## Better use get_node(StringName) to find desired component!

@tool
extends Node

# StringName: Array[Reference]
@onready var components: Dictionary = update_components()

func _ready():
	update_configuration_warnings()

func _get_configuration_warnings():
	return ["Better use get_node(StringName) to find desired component!"]

func get_components(component: StringName) -> Array:
	if components.has(component):
		return components.get(component)
	else:
		Logger.debug_log(component + " not found", MESSAGE_TYPE.WARNING)
		return []


func update_components() -> Dictionary:
	var result = {}
	for c in get_children():
		result[c.name] = c
	return result

