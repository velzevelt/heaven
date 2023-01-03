extends Window

@onready var init_position = self.position

func _on_close_requested():
	self.visible = false

func reset_position():
	position = init_position
