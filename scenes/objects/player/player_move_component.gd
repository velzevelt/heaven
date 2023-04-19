# based on https://github.com/axel37/godot-quake-movement/blob/main/Player.gd
class_name PlayerMoveComponent
extends Node3D # It inherits from Node3D only for easier debugging

@export_group('Crouch')
@export var player_collision_shape: CollisionShape3D
@export var player_standing_shape: Shape3D
@export var player_crouching_shape: Shape3D

@export_group('Dependencies')
@export var velocity_component: VelocityComponent
@export var standing_velocity_component: VelocityComponent
@export var crouching_velocity_component: VelocityComponent
@export var head: Head
@export var player_body: CharacterBody3D

@export_group('Behaviour') 
@export var can_move := true
@export var can_jump := true
@export var air_control := true
#@export var wall_slide_angle: float = 46
@export var auto_jump := false # Auto bunnyhopping

@onready var max_falling_speed: float = velocity_component.gravity * -5 # When this is reached, we stop increasing falling speed

var wish_jump := false # If true, player has queued a jump : the jump key can be held down before hitting the ground to jump.
var wish_dir: Vector3 = Vector3() # Desired travel direction of the player
var vertical_velocity: float = 0 # Vertical component of our velocity. 

var forward_action := 'forward'
var backward_action := 'backward'
var right_action := 'right'
var left_action := 'left'
var jump_action := 'jump'
var crouch_action := 'crouch'

# The next two variables are used to display corresponding vectors in game world.
var debug_horizontal_velocity: Vector3
var accelerate_return: Vector3

enum States {
	STANDING,
	CROUCHING
}

var current_state = States.STANDING

func _ready():
	# We tell our DebugLayer to draw those vectors in the game world.
	if OS.is_debug_build():
		DebugLayer.draw.add_vector(self, "wish_dir", 1, 4, Color(0,1,0, 0.5)) # Green, WISHDIR
		DebugLayer.draw.add_vector(self, "accelerate_return", 1, 4, Color(0,0,1, 0.25)) # Blue, ACCEL
		DebugLayer.draw.add_vector(self, "debug_horizontal_velocity", 2, 4, Color(1,0,0, 1)) # Red, VELOCITY
	
#	player_body.floor_block_on_wall = false # allow surfing on walls

func _update_wish_dir():
	if can_move and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var forward_input: float = Input.get_action_strength(backward_action) - Input.get_action_strength(forward_action)
		var strafe_input: float = Input.get_action_strength(right_action) - Input.get_action_strength(left_action)
		wish_dir = Vector3(strafe_input, 0, forward_input).rotated(Vector3.UP, player_body.global_transform.basis.get_euler().y).normalized()
	else:
		wish_dir = Vector3.ZERO

func _physics_process(delta):
	_update_wish_dir()
	queue_jump()
	queue_crouch()
	
	
	
	if player_body.is_on_floor(): 
		if wish_jump: # If we're on the ground but wish_jump is still true, this means we've just landed
			vertical_velocity = velocity_component.jump_velocity # Jump
			player_body.velocity = move_air(wish_dir, player_body.velocity, delta) # Mimic Quake's way of treating first frame after landing as still in the air
			wish_jump = false # We have jumped, the player needs to press jump key again
			
		else: # Player is on the ground. Move normally, apply friction
			vertical_velocity = 0
			player_body.velocity = move_ground(wish_dir, player_body.velocity, delta)
			
	else: # We're in the air. Do not apply friction
		vertical_velocity -= velocity_component.gravity * delta * velocity_component.mass if vertical_velocity >= max_falling_speed else 0 # Stop adding to vertical velocity once terminal velocity is reached
		var vel = player_body.velocity
		if player_body.is_on_wall():
#			vel = vel.snapped(player_body.get_wall_normal())
			vel = vel.slide(player_body.get_wall_normal())
			vel = accelerate(wish_dir, vel, velocity_component.move_accel, velocity_component.max_speed, delta)
			vertical_velocity = vel.y
		
		
		player_body.velocity = move_air(wish_dir, vel, delta)
	
	if player_body.is_on_ceiling(): # We've hit a ceiling, usually after a jump. Vertical velocity is reset to cancel any remaining jump momentum
		vertical_velocity = 0
	
	player_body.move_and_slide()
	velocity_component.last_speed = player_body.velocity.length()
	debug_horizontal_velocity = Vector3(player_body.velocity.x, 0, player_body.velocity.z) # Horizontal velocity to be displayed


func queue_crouch() -> void:
	if not can_move:
		return
	
	if Input.is_action_just_pressed(crouch_action):
		if current_state != States.CROUCHING:
			current_state = States.CROUCHING
			player_collision_shape.shape = player_crouching_shape
			velocity_component = crouching_velocity_component
			
	elif Input.is_action_just_released(crouch_action):
		if current_state == States.CROUCHING and not wish_jump:
			current_state = States.STANDING
			player_collision_shape.shape = player_standing_shape
			velocity_component = standing_velocity_component


# Set wish_jump depending on player input.
func queue_jump() -> void:
	if not can_jump:
		return
	
	# If auto_jump is true, the player keeps jumping as long as the key is kept down
	if auto_jump:
		wish_jump = true if Input.is_action_pressed(jump_action) else false
		return
	
	if Input.is_action_just_pressed(jump_action) and not wish_jump:
		wish_jump = true
	if Input.is_action_just_released(jump_action):
		wish_jump = false



# Scale down horizontal velocity
func apply_friction(input_velocity: Vector3, delta: float, friction: float) -> Vector3:
	var speed: float = input_velocity.length()
	var scaled_velocity: Vector3
	
	# Check that speed isn't 0, this is to avoid divide by zero errors
	if speed != 0:
		var drop = speed * friction * delta # Amount of speed to be reduced by friction
		# ((max(speed - drop, 0) / speed) will return a number between 0 and 1, this is our speed multiplier from friction
		# The max() is there to avoid anything from happening in the case where the user sets friction to a negative value
		scaled_velocity = input_velocity * max(speed - drop, 0) / speed
	# Stop altogether if we're going too slow to notice
	if speed < 0.1:
		return scaled_velocity * 0
	return scaled_velocity


@warning_ignore("shadowed_variable")
func accelerate(wish_dir: Vector3, input_velocity: Vector3, accel: float, max_speed: float, delta: float) -> Vector3:
	# Current speed is calculated by projecting our velocity onto wish_dir.
	# We can thus manipulate our wish_dir to trick the engine into thinking we're going slower than we actually are, allowing us to accelerate further.
	var current_speed: float = input_velocity.dot(wish_dir)
	
	# Next, we calculate the speed to be added for the next frame.
	# If our current speed is low enough, we will add the max acceleration.
	# If we're going too fast, our acceleration will be reduced (until it evenutually hits 0, where we don't add any more speed).
	var add_speed: float = clampf(max_speed - current_speed, 0, accel * delta)
	
	# Put the new velocity in a variable, so the vector can be displayed.
	accelerate_return = input_velocity + wish_dir * add_speed
	return accelerate_return


# Apply friction, then accelerate
@warning_ignore("shadowed_variable")
func move_ground(wish_dir: Vector3, input_velocity: Vector3, delta: float) -> Vector3:
	# We first work on only on the horizontal components of our current velocity
	var next_velocity: Vector3 = Vector3.ZERO
	next_velocity.x = input_velocity.x
	next_velocity.z = input_velocity.z
	next_velocity = apply_friction(next_velocity, delta, velocity_component.friction) # Scale down velocity
	next_velocity = accelerate(wish_dir, next_velocity, velocity_component.move_accel, velocity_component.max_speed, delta)
	
	# Then get back our vertical component, and move the player
	next_velocity.y = vertical_velocity
	player_body.velocity = next_velocity
	player_body.up_direction = Vector3.UP
	player_body.floor_stop_on_slope = true
	
	return next_velocity
#	player_body.move_and_slide()


# Accelerate without applying friction (with a lower allowed max_speed)
@warning_ignore("shadowed_variable")
func move_air(wish_dir: Vector3, input_velocity: Vector3, delta: float) -> Vector3:
	# We first work on only on the horizontal components of our current velocity
	var next_velocity: Vector3 = Vector3.ZERO
	next_velocity.x = input_velocity.x
	next_velocity.z = input_velocity.z
	next_velocity = accelerate(wish_dir, next_velocity, velocity_component.move_accel, velocity_component.max_air_speed, delta)
	
	# Then get back our vertical component, and move the player
	next_velocity.y = vertical_velocity
	player_body.up_direction = Vector3.UP
	player_body.floor_stop_on_slope = false
	
	return next_velocity
#	player_body.velocity = next_velocity
	
#	player_body.move_and_slide()
