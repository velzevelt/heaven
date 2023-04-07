extends RigidBody3D

@export var joint: HingeJoint3D
@export var fix_threshold: float = 0.4
@export var active_layer: int = 4

@onready var upper_limit: float = joint.get_param(HingeJoint3D.PARAM_LIMIT_UPPER) - fix_threshold
@onready var lower_limit: float = joint.get_param(HingeJoint3D.PARAM_LIMIT_LOWER) + fix_threshold

var product: float = 0.0
var body

var normal_direction: Vector3:
	get:
		return self.transform.basis.z

func _ready():
	DebugLayer.draw.add_vector(self, 'global_position')


func _on_area_3d_body_entered(body: CharacterBody3D):
	self.body = body


func _on_area_3d_body_exited(body):
	self.body = null

func _physics_process(delta):
	if is_instance_valid(body):
		
		var push_direction = (self.global_position - body.global_position).normalized()
		self.apply_force(push_direction * 10, body.global_position)
#
#		if product > 0.0:
#			self.apply_central_force(Vector3(0, 0, speed)) #, body.global_position)
#		else:
#			self.apply_central_force(Vector3(0, 0, -speed)) #, body.global_position)
#
#	if Input.is_action_just_pressed('left_click'):
#		self.linear_velocity = Vector3(0, 0, 1)
#
#	if Input.is_action_just_pressed('right_click'):
#		self.linear_velocity = Vector3(0, 0, -1)
