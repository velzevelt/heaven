extends Button

@export var target_window: Control

func _on_pressed():
	target_window.visible = false
