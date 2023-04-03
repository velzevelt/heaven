class_name VelocityComponent
extends Node

@export var max_speed := 150.0
@export var min_speed := 4.0
@export var max_air_speed := 0.6
@export var jump_velocity := 6.0
@export var jump_release := 2.0
@export var mass := 1.0
@export var friction := 0.3
@export var move_accel := 60

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var last_speed: float = 1.0:
	get:
		return last_speed
	set(value):
		last_speed = value
		if last_speed > max_speed:
			last_speed = max_speed

var last_velocity: Vector3 = Vector3()
