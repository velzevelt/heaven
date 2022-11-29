extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const JUMP_RELEASE = 2.0
const MASS = 1.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		self.velocity.y -= gravity * MASS *  delta

	# Handle Jump. Holding jump key longer make jump higher
	if Input.is_action_just_pressed("jump") and is_on_floor():
		self.velocity.y = JUMP_VELOCITY
	if Input.is_action_just_released("jump") and not is_on_floor() and velocity.y > 0:
		self.velocity.y /= JUMP_RELEASE
	
	
	move_and_slide()
	
