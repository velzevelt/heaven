extends Node

@export var target_window: Control
@export var condition: PopUpCondition

func _ready():
	if not condition.enabled:
		target_window.visible = false


func _on_do_not_show_button_toggled(button_pressed):
	condition.enabled = not button_pressed
