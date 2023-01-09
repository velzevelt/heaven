extends Window

@onready var _debug_layer = get_parent() as CanvasLayer
@onready var _init_position = self.position


func _on_close_requested():
	self.visible = false


func reset_position():
	position = _init_position


func _on_debug_layer_visibility_changed():
	self.visible = _debug_layer.visible
	if self.visible:
		reset_position()
