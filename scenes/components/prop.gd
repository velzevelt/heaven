extends RigidBody3D

signal object_entered_strict(object)
signal object_exited(object)

var body: PhysicsBody3D
var raycast_data
var is_dragging := false
var push_force := 5
var pull_force := 10

var can_drag := true

func _ready():
	object_entered_strict.connect(_on_object_entered)
	object_exited.connect(_on_object_exited)

func _on_object_entered(object):
	if object.is_in_group('player'):
		can_drag = false

func _on_object_exited(object):
	if object.is_in_group('player'):
		can_drag = true


func _physics_process(_delta):
	if is_dragging and can_drag:
		if Input.is_action_just_released('interact') or not raycast_data.player.is_on_floor():
			is_dragging = false
			return
		
		if Input.is_action_just_pressed('right_click'):
			apply_impulse(-raycast_data.marker.global_transform.basis.z * push_force)
			is_dragging = false
			return
		
		if Input.is_action_pressed('interact'):
			linear_velocity = (raycast_data.marker.global_position - global_position) * pull_force
		


func interact_begin(data):
	raycast_data = data


func interact_process():
	if Input.is_action_just_pressed('interact'):
		is_dragging = true


func interact_end():
	pass
