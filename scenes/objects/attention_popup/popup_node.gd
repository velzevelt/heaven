extends Node

@export var target_window: Control
@export var condition: Resource

func _ready():
	target_window.visible = condition.enabled and condition.condition()


func _on_do_not_show_button_toggled(button_pressed):
	condition.enabled = not button_pressed
