extends Node

@export var hook_raycast: RayCast3D
@export var body: CharacterBody3D
@export var velocity_component: VelocityComponent
@export var player_move_component: PlayerMoveComponent
@export var elasticity: float = 1.0
@export var base_pull_force: float = 15.0
@export var detachment_distance: float = 1.5
@export var hook: PackedScene
#@export var input_component: GrapplingHookInputComponent


var hit_point: Vector3 = Vector3()
var grappling := false


func _physics_process(delta):
	if hook_raycast.is_colliding() and Input.is_action_just_pressed("forward"):
		hit_point = hook_raycast.get_collision_point()
		var hit_direction = body.global_position.direction_to(hit_point)
		
		# YOU CAN'T ADD JOINTS IN RUNTIME
		# That's why need to use PackedScene with Objects and Joint
		# You can delete joints in runtime
		
		var instance = hook.instantiate() as Node3D
		var rb = instance.get_node('RigidBody3D') as RigidBody3D
		var sb = instance.get_node('StaticBody3D') as StaticBody3D
		var joint = instance.get_node('PinJoint3D') as PinJoint3D
		joint.node_a = ''
		joint.node_b = ''
		
		sb.add_collision_exception_with(body)
		rb.add_collision_exception_with(body)
		sb.position = hit_point
		joint.position = sb.position
		rb.position = $%Head.global_position
		
		body.get_parent().call_deferred('add_child', instance)
		await rb.tree_entered and sb.tree_entered
		rb.apply_central_impulse(hit_direction * base_pull_force)
		
		await get_tree().create_timer(0.4).timeout
		joint.node_a = rb.get_path()
		joint.node_b = sb.get_path()
