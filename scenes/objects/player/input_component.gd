class_name InputComponent
extends Node

signal action_just_pressed(action_name)
signal action_pressed(action_name)
signal action_just_released(action_name)

@export var action_name: String



func _process(delta):
	if Input.is_action_just_pressed(action_name):
		action_just_pressed.emit(action_name)
	
	if Input.is_action_pressed(action_name):
		action_pressed.emit(action_name)
	
	if Input.is_action_just_released(action_name):
		action_just_released.emit(action_name)
