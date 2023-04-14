class_name MenuComponent
extends CanvasLayer

@export var on_back: BACK_ACTIONS = BACK_ACTIONS.CLOSE

enum BACK_ACTIONS {CLOSE, HIDE, EXIT_GAME, IGNORE, CUSTOM}


func _on_back_button_pressed():
	match on_back:
		BACK_ACTIONS.CLOSE:
			queue_free()
		BACK_ACTIONS.HIDE:
			hide()
		BACK_ACTIONS.EXIT_GAME:
			get_tree().quit()
		BACK_ACTIONS.IGNORE:
			pass
		BACK_ACTIONS.CUSTOM:
			custom_exit()



func custom_exit():
	pass


func _on_ui_cancel_just_pressed():
	_on_back_button_pressed()


func _unhandled_input(_event):
	if Input.is_action_just_pressed('ui_cancel'):
		_on_ui_cancel_just_pressed()


static func open_menu(menu: PackedScene, bind_parent: Node):
	var instance = MenuComponent.create_menu(menu)
	if bind_parent == null:
		Logger.debug_log("Missing bind_parent", MESSAGE_TYPE.ERROR)
		return null
	if instance != null:
		bind_parent.call_deferred('add_child', instance)
		return instance


static func create_menu(menu: PackedScene):
	if menu != null:
		var instance = menu.instantiate()
		return instance
	else:
		Logger.debug_log('Menu is not set in inspector', MESSAGE_TYPE.ERROR)
		return null


static func close_menu(menu_instance):
	if is_instance_valid(menu_instance):
		if menu_instance.has_method("_on_back_button_pressed"):
			menu_instance._on_back_button_pressed()
		else:
			Logger.debug_log("Menu missing close functionality!", MESSAGE_TYPE.WARNING)
	else:
		Logger.debug_log("Null menu", MESSAGE_TYPE.ERROR)


