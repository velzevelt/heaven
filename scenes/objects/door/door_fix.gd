extends RigidBody3D

@export var joint: HingeJoint3D
@export var fix_threshold: float = 0.4
@export var active_layer: int = 4
@export var max_force: float = 2.0

@onready var upper_limit: float = joint.get_param(HingeJoint3D.PARAM_LIMIT_UPPER) - fix_threshold
@onready var lower_limit: float = joint.get_param(HingeJoint3D.PARAM_LIMIT_LOWER) + fix_threshold


func _physics_process(_delta):
	if (self.rotation.y > upper_limit or self.rotation.y < lower_limit) and get_contact_count() != 0:
		self.set_collision_layer_value(active_layer, true)
	else:
		self.set_collision_layer_value(active_layer, false)
