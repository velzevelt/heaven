class_name PlayerMoveComponent
extends Node

@export var velocity_component: VelocityComponent
@export var input_component: InputComponent
@export var head: Head
@export var player_body: CharacterBody3D 
@export var air_control := true
@export var can_move := true
@export var can_jump := true

var first_jump = true
var jump_direction: Vector3 = Vector3()
var input_direction: Vector3 = Vector3()

func _ready():
	if is_instance_valid(input_component):
		input_component.action_just_pressed.connect(_on_jump_pressed)
		input_component.action_just_released.connect(_on_jump_released)
	else:
		Logger.debug_log('Missing input_component', MESSAGE_TYPE.WARNING)


func _physics_process(_delta):
	if not player_body.is_on_floor():
#		player_body.velocity.y -= velocity_component.gravity * velocity_component.mass * delta
		player_body.velocity.y = move_toward(player_body.velocity.y, -velocity_component.gravity * velocity_component.mass * velocity_component.last_speed, 0.25)
		
#		if air_control:
#			var new_direction = (input_direction + jump_direction).normalized()
#
#			player_body.velocity.x = new_direction.x * velocity_component.last_speed
#			player_body.velocity.z = new_direction.z * velocity_component.last_speed
		
	else:
		var input_dir = Input.get_vector("left", "right", "forward", "backward")
		input_direction = (player_body.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if input_direction != Vector3.ZERO and can_move:
			var current_speed = player_body.velocity.dot(input_direction)
			var add_speed = clampf(velocity_component.max_speed - current_speed, 0, velocity_component.max_speed * 2 * get_physics_process_delta_time())
			var final_velocity = add_speed * input_direction
			
			player_body.velocity.x = move_toward(player_body.velocity.x, final_velocity.x, 0.4)
			player_body.velocity.z = move_toward(player_body.velocity.z, final_velocity.z, 0.4)
#			player_body.velocity.z = move_toward(player_body.velocity.z, input_direction.z * velocity_component.min_speed, 0.3)
#			player_body.velocity.x = move_toward(player_body.velocity.x, input_direction.x * velocity_component.min_speed, 0.3)
			velocity_component.last_speed = player_body.velocity.length()
		else:
			player_body.velocity.x = move_toward(player_body.velocity.x, 0, velocity_component.friction)
			player_body.velocity.z = move_toward(player_body.velocity.z, 0, velocity_component.friction)
			velocity_component.last_speed = move_toward(velocity_component.last_speed, 1.0, velocity_component.friction)
			
	
	player_body.move_and_slide()


# Handle Jump. Holding jump key longer make jump higher
func _on_jump_pressed(_action_name):
	if player_body.is_on_floor() and can_jump:
		first_jump = true
		jump(velocity_component.jump_velocity)


func _on_jump_released(_action_name):
	if first_jump and not player_body.is_on_floor():
		if player_body.velocity.y > 0:
			player_body.velocity.y /= velocity_component.jump_release
		first_jump = false


func jump(jump_velocity: float):
	player_body.velocity.y = jump_velocity
	velocity_component.last_velocity.y = jump_velocity

	var current_speed = player_body.velocity.dot(input_direction)
	var add_speed = clampf(velocity_component.max_speed - current_speed, 0, velocity_component.max_speed * 2 * get_physics_process_delta_time())
	var final_velocity = add_speed * input_direction
	
	print(current_speed)
#	print(input_direction, final_velocity, Vector3(velocity_component.max_speed - current_speed, current_speed, add_speed))
	
	player_body.velocity.x += final_velocity.x
	player_body.velocity.z += final_velocity.z
	
#	player_body.velocity.x = move_toward(player_body.velocity.x, final_velocity.x, 0.4)
#	player_body.velocity.z = move_toward(player_body.velocity.z, final_velocity.z, 0.4)

	velocity_component.last_speed = player_body.velocity.length()
	velocity_component.last_velocity = Vector3(player_body.velocity.x, velocity_component.last_velocity.y, player_body.velocity.z)
	
	jump_direction = (velocity_component.last_velocity + input_direction).normalized()
