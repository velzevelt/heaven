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


func _physics_process(_delta):
	if self.rotation.y > upper_limit:
		for body in get_colliding_bodies():
			if body is CharacterBody3D:
				body = body as CharacterBody3D
				var direction = -body.global_transform.basis.z
				direction = direction.dot(self.normal_direction)
				print(direction)
				if direction < 0:
					self.set_collision_layer_value(active_layer, true)
				elif direction > 0:
					self.set_collision_layer_value(active_layer, false)
	
	if self.rotation.y < lower_limit:
		print(1)

