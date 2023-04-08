extends RigidBody3D

@export var fix_threshold: float = 0.4
@export var active_layer: int = 4

var body: PhysicsBody3D

var normal_direction: Vector3:
	get:
		return self.transform.basis.z


func _on_area_3d_body_entered(body):
	self.body = body

func _on_area_3d_body_exited(body):
	self.body = null


func _physics_process(delta):
	push_door(self.body)


func push_door(body):
	if is_instance_valid(body):
		var push_direction = (self.global_position - body.global_position).normalized()
		self.apply_central_force(push_direction * 100)


func interact_begin(data):
	pass

func interact_process():
	pass

func interact_end():
	pass
