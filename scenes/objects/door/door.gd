extends RigidBody3D

@export var fix_threshold: float = 0.4
@export var active_layer: int = 4

var body: PhysicsBody3D
var raycast_data
var is_dragging := false


var normal_direction: Vector3:
	get:
		return self.transform.basis.z


func _on_area_3d_body_entered(body):
	self.body = body

func _on_area_3d_body_exited(body):
	self.body = null


func _physics_process(_delta):
	if is_dragging:
		if Input.is_action_pressed('interact'):
			push_door(raycast_data.player, 2, true)
		
		if Input.is_action_just_released('interact') or raycast_data.from.target_position.length() < (self.global_position - raycast_data.player.global_position).length():
			is_dragging = false
	else:
		if is_instance_valid(body):
			push_door(self.body, self.body.velocity.length() + 1)


func push_door(body, push_force=1, opposite_direction=false):
	if is_instance_valid(body):
		var push_direction = (self.global_position - body.global_position).normalized()
		if opposite_direction:
			push_direction = -push_direction
		self.linear_velocity = push_direction * push_force


func interact_begin(data):
	raycast_data = data

func interact_process():
	if Input.is_action_pressed('interact'):
		is_dragging = true

func interact_end():
	pass
