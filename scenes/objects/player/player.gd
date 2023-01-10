class_name Player extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 6.0
const JUMP_RELEASE = 2.0
const MASS = 1.0
const FRICTION = 10.0

@onready var head = $%Head as Head

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var first_jump = true

func _physics_process(delta):
	if not is_on_floor():
		self.velocity.y -= gravity * MASS *  delta
	else:
		self.velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		self.velocity.z = move_toward(velocity.z, 0, FRICTION * delta)

	# Handle Jump. Holding jump key longer make jump higher
	if Input.is_action_just_pressed("jump") and is_on_floor():
		first_jump = true
		jump(JUMP_VELOCITY)
		
	if Input.is_action_just_released("jump") and not is_on_floor() and first_jump:
#		if self.velocity.y > 0:
#			self.velocity.y /= JUMP_RELEASE
		self.velocity.y /= JUMP_RELEASE
		Logger.debug_log('test')
		first_jump = false
	
	
	
	move_and_slide()
	

func jump(jump_velocity : float):
	self.velocity.y = jump_velocity
	
	var jump_direction = head.get_jump_direction()
	self.velocity.x = jump_direction.x * SPEED
	self.velocity.z = jump_direction.z * SPEED


