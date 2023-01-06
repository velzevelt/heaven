extends Window

@onready var init_position = self.position
@onready var temp_mouse_mode = Input.mouse_mode

func _on_close_requested():
	self.visible = false

func reset_position():
	position = init_position


func _on_window_input(event):
	if Input.is_action_just_pressed("left_click"):
		get_tree().paused = true


func _on_focus_exited():
	get_tree().paused = false


func _on_visibility_changed():
	if visible:
		temp_mouse_mode = Input.mouse_mode
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
