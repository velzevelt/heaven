extends Node

@export_category("Dependencies")
@export var camera: Camera3D
@export var move_component: PlayerMoveComponent
@export var jump_input: JumpInputComponent
@export var player_body: CharacterBody3D

@export_category("Settings")
## Cannot be greater than 180 degrees
@export var max_fov = 120.0


@onready var min_fov = camera.fov


func _ready():
	jump_input.jump_pressed.connect(_on_jump_pressed)
	


func _on_jump_pressed():
	var new_fov = clampf(min_fov + move_component.last_speed, min_fov, max_fov)
	
	var tween = create_tween()
	tween.tween_property(camera, 'fov', new_fov, 0.1)


func _physics_process(delta):
	if player_body.is_on_floor():
		camera.fov = move_toward(camera.fov, min_fov, move_component.FRICTION)
