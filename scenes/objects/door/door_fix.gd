extends RigidBody3D

@export var joint: HingeJoint3D
@export var fix_threshold: float = 0.4
@export var active_layer: int = 4
@export var max_force: float = 2.0

@onready var upper_limit: float = joint.get_param(HingeJoint3D.PARAM_LIMIT_UPPER) - fix_threshold
@onready var lower_limit: float = joint.get_param(HingeJoint3D.PARAM_LIMIT_LOWER) + fix_threshold

var normal_direction: Vector3:
	get:
		return self.global_transform.basis.z

func _ready():
	DebugLayer.draw.add_vector(self, 'normal_direction')
	self.body_entered.connect(_on_body_entered)


func _on_area_3d_body_entered(body):
	_on_body_entered(body)

func _on_body_entered(body):
	if self.rotation.y >= upper_limit:
		self.set_collision_layer_value(active_layer, is_looking_at_me(body))
	elif self.rotation.y <= lower_limit:
		self.set_collision_layer_value(active_layer, not is_looking_at_me(body))


func is_looking_at_me(body: Node3D):
	var product = body.global_transform.basis.z
	product = product.dot(self.normal_direction)
	return product > 0



