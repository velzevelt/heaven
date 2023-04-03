class_name VelocityComponent
extends Node

@export var max_speed: float = 6.0
@export var min_speed: float = 4.0
@export var max_air_speed: float = 0.6
@export var jump_velocity: float = 6.0
@export var jump_release: float = 2.0
@export var mass: float = 1.0
@export var friction: float = 0.3
@export var move_accel: float = self.max_speed * 10

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var last_speed: float = 1.0:
	get:
		return last_speed
	set(value):
		last_speed = value
		if last_speed > max_speed:
			last_speed = max_speed

var last_velocity: Vector3 = Vector3()
