class_name MainMenu
extends MenuComponent

@export var map_select_menu: PackedScene = preload("res://scenes/map_select_menu/map_select_menu.tscn")
@export var settings_menu: PackedScene = preload("res://scenes/settings_menu/settings_menu.tscn")

var _map_select_menu_instance
var _settings_menu_instance

func _on_play_button_pressed():
	if map_select_menu != null:
		if not is_instance_valid(_map_select_menu_instance):
			_map_select_menu_instance = MenuComponent.open_menu(map_select_menu, self)
	else:
		Logger.debug_log('Missing map_select_menu!', MESSAGE_TYPE.ERROR)



func _on_settings_button_pressed():
	_settings_menu_instance = create_settings_menu(self)
	if is_instance_valid(_settings_menu_instance):
		call_deferred('add_child', _settings_menu_instance)
	


func create_settings_menu(bind_parent):
	if settings_menu != null:
		print(self)
		if not is_instance_valid(_settings_menu_instance):
			var settings_menu_instance = MenuComponent.create_menu(settings_menu)
			return settings_menu_instance
	else:
		Logger.debug_log('Missing settings_menu!', MESSAGE_TYPE.ERROR)
