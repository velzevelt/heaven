class_name PlayerMoveComponent
extends Node3D # It's inherits from Node3D only for easier debugging

@export var velocity_component: VelocityComponent
@export var head: Head
@export var player_body: CharacterBody3D 
@export var air_control := true
@export var can_move := true
@export var can_jump := true

var first_jump = true
var look_direction: Vector3 = Vector3()
#var input_direction: Vector3 = Vector3()

var wish_dir: Vector3 = Vector3()

var forward_action = 'forward'
var backward_action = 'backward'
var right_action = 'right'
var left_action = 'left'
var jump_action = 'jump'

func _ready():
	DebugLayer.draw.add_vector(self, 'wish_dir')
	DebugLayer.draw.add_vector(self, 'look_direction', 1, 12, Color.BROWN)
	


func _physics_process(_delta):
	if not player_body.is_on_floor():
		player_body.velocity.y = move_toward(player_body.velocity.y, -velocity_component.gravity * velocity_component.mass * velocity_component.last_speed, 0.25)
		
#		if air_control:
#			var new_direction = (input_direction + jump_direction).normalized()
#
#			player_body.velocity.x = new_direction.x * velocity_component.last_speed
#			player_body.velocity.z = new_direction.z * velocity_component.last_speed
		
	else:
		#var input_dir = Input.get_vector("left", "right", "forward", "backward")
		var input_dir = Input.get_vector(left_action, right_action, forward_action, backward_action)
		
		
		input_dir = (player_body.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		wish_dir = input_dir
		
		
		if wish_dir != Vector3.ZERO and can_move:
			var current_speed = player_body.velocity.dot(wish_dir)
			var add_speed = velocity_component.max_speed - current_speed
			
			player_body.velocity.x += wish_dir.x * add_speed
			player_body.velocity.z += wish_dir.z * add_speed 
			velocity_component.last_speed = player_body.velocity.length()
		else:
			pass
			#apply_friction()
	
	
	if Input.is_action_just_pressed(jump_action):
		_on_jump_pressed()
	
	if Input.is_action_just_released(jump_action):
		_on_jump_released()
	
	
	player_body.move_and_slide()


# Handle Jump. Holding jump key longer make jump higher
func _on_jump_pressed():
	if player_body.is_on_floor() and can_jump:
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
	
	look_direction = head.get_jump_direction()
	
	var current_speed = player_body.velocity.dot(look_direction)
	var add_speed = velocity_component.max_speed - current_speed
	
	player_body.velocity.x += wish_dir.x * add_speed
	player_body.velocity.z += wish_dir.z * add_speed
	
	velocity_component.last_speed = player_body.velocity.length()
	velocity_component.last_velocity = Vector3(player_body.velocity.x, velocity_component.last_velocity.y, player_body.velocity.z)


# Scale down horizontal velocity
func apply_friction(input_velocity: Vector3, delta: float, friction: float)-> Vector3:
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


func accelerate(wishdir: Vector3, input_velocity: Vector3, accel: float, max_speed: float, delta: float)-> Vector3:
	# Current speed is calculated by projecting our velocity onto wishdir.
	# We can thus manipulate our wishdir to trick the engine into thinking we're going slower than we actually are, allowing us to accelerate further.
	var current_speed: float = input_velocity.dot(wishdir)
	
	# Next, we calculate the speed to be added for the next frame.
	# If our current speed is low enough, we will add the max acceleration.
	# If we're going too fast, our acceleration will be reduced (until it evenutually hits 0, where we don't add any more speed).
	var add_speed: float = clamp(max_speed - current_speed, 0, accel * delta)
	
	# Put the new velocity in a variable, so the vector can be displayed.
	var accelerate_return = input_velocity + wishdir * add_speed
	return accelerate_return
