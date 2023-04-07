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
		return self.global_transform.basis.z

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
		if is_pushing:
			var product = body.global_position.normalized().dot(normal_direction)
			pass
	
	if Input.is_action_just_pressed("left_click"):
		apply_central_impulse(Vector3(0, 0, -1))
	
	if Input.is_action_just_pressed("jump"):
		apply_central_impulse(Vector3(0, 0, 1))
