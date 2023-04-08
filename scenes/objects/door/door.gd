extends RigidBody3D

@export var fix_threshold: float = 0.4
@export var active_layer: int = 4

var body: PhysicsBody3D
var raycast_data

var normal_direction: Vector3:
	get:
		return self.transform.basis.z


func _on_area_3d_body_entered(body):
	self.body = body

func _on_area_3d_body_exited(body):
	self.body = null


func _physics_process(delta):
	push_door(self.body)


func push_door(body, push_force=100, opposite_direction=false):
	if is_instance_valid(body):
		var push_direction = (self.global_position - body.global_position).normalized()
		if opposite_direction:
			push_direction = -push_direction
		self.apply_central_force(push_direction * push_force)


func interact_begin(data):
	raycast_data = data

func interact_process():
	if Input.is_action_pressed('interact') and not is_instance_valid(self.body):
		push_door(raycast_data.player, 2, true)
	

func interact_end():
	pass
