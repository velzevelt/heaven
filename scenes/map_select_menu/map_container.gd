class_name MapContainer
extends VBoxContainer

signal container_pressed(map_collection)

var map_collection

func _on_pressed():
	container_pressed.emit(map_collection)
	var children = get_children()
	children.pop_front()
	for c in children:
		c.visible = !c.visible
	


func _on_button_pressed():
	_on_pressed()
