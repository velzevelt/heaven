class_name MapEscapeMenu
extends MenuComponent

var main_menu_data = preload("res://scenes/maps/main_menu/map_data.tres") as MapData

func _ready():
	Settings.show_cursor()

func _on_ui_cancel_just_pressed():
	_on_play_button_pressed()

func _on_play_button_pressed():
	Settings.hide_cursor()
	queue_free()


func custom_exit():
	SceneLoader.change_scene(main_menu_data)


func _on_settings_button_pressed():
	var settings_menu = MainMenu.new().create_settings_menu(self)
	call_deferred('add_child', settings_menu)
