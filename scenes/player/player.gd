extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 6.0
const JUMP_RELEASE = 2.0
const MASS = 1.0
const FRICTION = 10

@onready var head = $Head as Head

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		self.velocity.y -= gravity * MASS *  delta
	else:
		self.velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		self.velocity.z = move_toward(velocity.z, 0, FRICTION * delta)

	# Handle Jump. Holding jump key longer make jump higher
	if Input.is_action_just_pressed("jump") and is_on_floor():
		self.velocity.y = JUMP_VELOCITY
		
		var jump_dir = head.get_jump_direction()
		jump_dir *= SPEED
		
		self.velocity.x = jump_dir.x
		self.velocity.z = jump_dir.z
			
		
	if Input.is_action_just_released("jump") and not is_on_floor() and velocity.y > 0:
		self.velocity.y /= JUMP_RELEASE
	
	
	
	move_and_slide()
	
