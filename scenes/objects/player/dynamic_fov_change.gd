class_name DynamicFOVChange
extends Node

@export_category("Dependencies")
@export var camera: Camera3D
@export var velocity_component: VelocityComponent
@export var player_body: CharacterBody3D

@export_category("Settings")
## Cannot be greater than 180 degrees
@export var max_fov = 120.0

@onready var min_fov = camera.fov


func _physics_process(delta):
	var new_fov = clampf(min_fov + velocity_component.last_speed, min_fov, max_fov)
	var tween = create_tween()
	tween.tween_property(camera, 'fov', new_fov, 0.1)
