class_name JumpInputComponent
extends Node

signal jump_pressed
signal jump_released

func _unhandled_input(_event):
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if Input.is_action_just_pressed('jump'):
			jump_pressed.emit()
		if Input.is_action_just_released('jump'):
			jump_released.emit()
