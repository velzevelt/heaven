extends RigidBody3D

@export var closed := false:
	set(value):
		closed = value
		freeze = closed
	get:
		freeze = closed
		return closed

@export var joint: HingeJoint3D
@export var fix_threshold: float = 0.4
@export var active_layer: int = 4

@onready var upper_limit = joint.get_param(HingeJoint3D.PARAM_LIMIT_UPPER) - fix_threshold
@onready var lower_limit = joint.get_param(HingeJoint3D.PARAM_LIMIT_LOWER) + fix_threshold

var body: PhysicsBody3D
var raycast_data
var is_dragging := false
var product: float = 0.0

var normal_direction: Vector3:
	get:
		return self.transform.basis.z


@warning_ignore("shadowed_variable")
func _on_area_3d_body_entered(body):
	self.body = body

@warning_ignore("shadowed_variable")
func _on_area_3d_body_exited(body):
	self.body = null


func _ready():
	freeze = closed

func _physics_process(_delta):
	if closed:
		return
	
	if is_dragging:
		if Input.is_action_just_released('interact') or raycast_data.from.target_position.length() < (self.global_position - raycast_data.player.global_position).length():
			is_dragging = false
		
		if Input.is_action_pressed('interact'):
			product = -normal_direction.dot(raycast_data.player.global_position)
			linear_velocity = (raycast_data.door_marker.global_position - global_position).normalized() * 2
		
	else:
		if is_instance_valid(body):
			var push_direction = (self.global_position - body.global_position).normalized()
			self.apply_impulse(push_direction)
	

func _integrate_forces(_state: PhysicsDirectBodyState3D):
	if is_instance_valid(body):
		product = normal_direction.dot(body.global_position)
	
	
	if (rotation.y > upper_limit and product > 0.0) or (rotation.y < lower_limit and product < 0.0):
		linear_velocity = Vector3.ZERO


func interact_begin(data):
	raycast_data = data

func interact_process():
	if Input.is_action_pressed('interact'):
		is_dragging = true

func interact_end():
	pass
