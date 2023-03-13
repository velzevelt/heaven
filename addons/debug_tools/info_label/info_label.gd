@tool
class_name InfoLabel
extends Label

@export_node_path("Node") var target_path:
	set(value):
		target_path = value
		update_configuration_warnings()
@export var desired_property: String = "":
	set(value):
		desired_property = value
		update_configuration_warnings()

var _target

var _property_value:
	get:
		if is_instance_valid(_target):
			if _target == self:
				_property_value = "Cycle ref!"
			else:
				_property_value = _target.get(desired_property)
				if _property_value == null:
					_property_value = "Property does't exist!"
		else:
			_property_value = "Missing target or warnings occured!"
		
		return _property_value


func _get_configuration_warnings():
	var warnings = []
	if not target_path is NodePath:
		warnings.append('Missing target_path')
	if desired_property.is_empty():
		warnings.append('Missing property_name')
	
	return warnings


func _ready():
	update_configuration_warnings()
	if target_path != null:
		_target = get_node(target_path)


func _process(_delta):
	if not Engine.is_editor_hint() and self.visible:
		text = desired_property + ": " + str(self._property_value)
	if Engine.is_editor_hint():
		text = desired_property + ": "
