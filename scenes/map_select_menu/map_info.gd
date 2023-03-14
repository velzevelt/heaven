@tool
class_name MapInfoContainer
extends VBoxContainer

## Which "res://scenes/map_data.gd" properties will be shown
@export var show_properties: PackedStringArray:
	set(value):
		show_properties = value
	get:
		if show_properties == null or show_properties.is_empty():
			show_properties = _get_map_data_properties()
		return show_properties

func _get_map_data_properties() -> PackedStringArray:
	var properties = MapData.new().get_property_list()
	var res: PackedStringArray = []
	for property in properties:
		res.append(property['name'])
	return res


func _on_map_container_map_selected(map_data):
	for c in get_children():
		c.queue_free()
	
	var properties = map_data.get_property_list()
	for property in properties:
		if property['name'] in show_properties:
			if property['type'] == TYPE_STRING or property['type'] == TYPE_STRING_NAME:
				var text = map_data.get(property['name']) as String
				if not text.is_empty():
					var label = Label.new()
					label.add_theme_font_size_override('font_size', 45)
					label.text = text
					call_deferred('add_child', label)
