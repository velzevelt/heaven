@tool
class_name MapInfoContainer
extends VBoxContainer

var star_full = preload("res://sprites/star-fill.svg")
var star_half = preload("res://sprites/star-half.svg")


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
				_create_labels(property['name'], map_data.get(property['name']))
#				
			elif property['type'] == TYPE_FLOAT and property['name'] == 'difficulty':
				_create_stars(map_data.get(property['name']))


func _create_labels(key, value):
	if not value.is_empty():
		var label = Label.new()
		label.add_theme_font_size_override('font_size', 45)
		
		key = key.capitalize()
		label.text = "%s: %s" % [key, value]
		call_deferred('add_child', label)


func _create_stars(difficulty):
	var container = HBoxContainer.new()
	call_deferred('add_child', container)
	
	var full_star_step = 1.0
	var half_star_step = 0.5
	while difficulty >= 0.9: # Add full stars first 
		difficulty -= full_star_step
		var star = TextureRect.new()
		star.texture = star_full
		container.call_deferred('add_child', star)
	
	if difficulty >= half_star_step:
		var star = TextureRect.new()
		star.texture = star_half
		container.call_deferred('add_child', star)
