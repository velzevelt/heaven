extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MASS = 1.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * MASS *  delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_released("jump") and not is_on_floor():
		if velocity.y > 2.0:
			velocity.y /= 2.0
	# уменьшить ускорение при отжатии кнопки
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	
	
	move_and_slide()
	
