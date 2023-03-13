extends MenuComponent

var map_data: MapData

func _on_play_button_pressed():
	if self.map_data != null:
		SceneLoader.change_scene(map_data)

@warning_ignore("shadowed_variable")
func _on_map_info_map_selected(map_data):
	self.map_data = map_data

func _on_ui_cancel_just_pressed():
	_on_back_button_pressed()


@warning_ignore("shadowed_variable")
func _on_map_container_map_selected(map_data):
	self.map_data = map_data
