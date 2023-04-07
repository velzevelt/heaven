extends RigidBody3D

@export var joint: HingeJoint3D
@export var fix_threshold: float = 0.4
@export var active_layer: int = 4
@export var max_force: float = 2.0

@onready var upper_limit: float = joint.get_param(HingeJoint3D.PARAM_LIMIT_UPPER) - fix_threshold
@onready var lower_limit: float = joint.get_param(HingeJoint3D.PARAM_LIMIT_LOWER) + fix_threshold

var product: float = 0.0
var body

var shit: Vector3:
	get:
		return Vector3(self.rotation.y, lower_limit, upper_limit)

var normal_direction: Vector3:
	get:
		return self.global_transform.basis.z

func _ready():
	DebugLayer.draw.add_vector(self, 'normal_direction')


func _on_area_3d_body_entered(body):
	self.body = body


func _physics_process(delta):
	if self.rotation.y >= upper_limit:
		self.set_collision_layer_value(active_layer, is_looking_at_me(body))
	elif self.rotation.y <= lower_limit:
		self.set_collision_layer_value(active_layer, not is_looking_at_me(body))
	else:
		self.set_collision_layer_value(active_layer, false)


func is_looking_at_me(body: Node3D):
	product = body.global_position.normalized().dot(self.normal_direction)
	return product >= 0.0

