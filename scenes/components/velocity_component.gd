class_name VelocityComponent
extends Node

@export var max_speed := 150.0
@export var jump_velocity := 6.0
@export var jump_release := 2.0
@export var mass := 1.0
@export var friction := 0.3

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var last_speed: float = 1.0:
	get:
		return last_speed
	set(value):
		if value > max_speed:
			value = max_speed
		else:
			last_speed = value
var last_velocity: Vector3 = Vector3()
