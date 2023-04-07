extends RigidBody3D

@export var joint: HingeJoint3D
@export var fix_threshold: float = 0.4
@export var active_layer: int = 4
@export var max_force: float = 2.0

@onready var upper_limit: float = joint.get_param(HingeJoint3D.PARAM_LIMIT_UPPER) - fix_threshold
@onready var lower_limit: float = joint.get_param(HingeJoint3D.PARAM_LIMIT_LOWER) + fix_threshold

var is_pushing := false

var product: float = 0.0
var body

var normal_direction: Vector3:
	get:
		return self.transform.basis.z

func _ready():
	DebugLayer.draw.add_vector(self, 'normal_direction')


func _on_area_3d_body_entered(body: CharacterBody3D):
	self.body = body
	is_pushing = true


func _on_area_3d_body_exited(body):
	self.body = null
	is_pushing = false

func _physics_process(delta):
	if is_instance_valid(body):
		product = body.transform.basis.z.normalized().dot(self.normal_direction)
		if product > 0.0:
			self.apply_force(Vector3(0, 0, -14), body.global_position)
		else:
			self.apply_force(Vector3(0, 0, 14), body.global_position)
	
