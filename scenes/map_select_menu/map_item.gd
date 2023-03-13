class_name MapItem
extends Button


signal item_selected(map_data: MapData)

var map_data: MapData:
	set(value):
		map_data = value
		text = map_data.visible_name
	get:
		return map_data



func _on_pressed():
	item_selected.emit(map_data)
