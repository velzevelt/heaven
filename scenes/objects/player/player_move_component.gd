class_name PlayerMoveComponent
extends Node

@export var velocity_component: VelocityComponent
@export var input_component: JumpInputComponent
@export var head: Head
@export var player_body: CharacterBody3D 
@export var air_control := true

var first_jump = true


func _ready():
	input_component.jump_pressed.connect(_on_jump_pressed)
	input_component.jump_released.connect(_on_jump_released)

func _physics_process(delta):
	if not player_body.is_on_floor():
#		player_body.velocity.y -= velocity_component.gravity * velocity_component.mass * delta
		player_body.velocity.y = move_toward(player_body.velocity.y, -velocity_component.gravity * velocity_component.mass * velocity_component.last_speed, 0.25)
		
		if air_control:
			var forward = -player_body.global_transform.basis.z
			player_body.velocity.x = forward.x * velocity_component.last_speed
			player_body.velocity.z = forward.z * velocity_component.last_speed
		
	else:
		player_body.velocity.x = move_toward(player_body.velocity.x, 0, velocity_component.friction)
		player_body.velocity.z = move_toward(player_body.velocity.z, 0, velocity_component.friction)
		velocity_component.last_speed = move_toward(velocity_component.last_speed, 1.0, velocity_component.friction)
	
	player_body.move_and_slide()

# Handle Jump. Holding jump key longer make jump higher
func _on_jump_pressed():
	if player_body.is_on_floor():
		first_jump = true
		jump(velocity_component.jump_velocity)

func _on_jump_released():
	if first_jump and not player_body.is_on_floor():
		if player_body.velocity.y > 0:
			player_body.velocity.y /= velocity_component.jump_release
		first_jump = false


func jump(jump_velocity: float):
	player_body.velocity.y = jump_velocity
	velocity_component.last_velocity.y = jump_velocity

	var forward = -player_body.global_transform.basis.z
#	var jump_direction = head.get_jump_direction()
	player_body.velocity.x = forward.x * velocity_component.last_speed
	player_body.velocity.z = forward.z * velocity_component.last_speed
	velocity_component.last_speed = player_body.velocity.length()
	velocity_component.last_velocity = Vector3(player_body.velocity.x, velocity_component.last_velocity.y, player_body.velocity.z)
