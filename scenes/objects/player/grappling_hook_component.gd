extends Node

@export var hook_raycast: RayCast3D

## Scene with RigidBody3D, StaticBody3D and PinJoint3D connected between them
@export var hook: PackedScene = preload("res://scenes/objects/player/hook.tscn")

## Player body
@export var body: CharacterBody3D

@export var velocity_component: VelocityComponent

## Determine force of engagement to hit_point
@export var base_pull_force: float = 15.0

## Determine how long body be free untill it attached to _joint
@export var free_fly_time := 0.4

## Specific Input
#@export var input_component: GrapplingHookInputComponent

var hit_point: Vector3 = Vector3()
var grappling := false

var _hook_instance
var _rb
var _sb
var _joint

func _physics_process(_delta):
	if not is_instance_valid(_hook_instance) and hook_raycast.is_colliding() and Input.is_action_just_pressed("forward") and not grappling:
		
		# Take control from PlayerMoveComponent to self
		if body.has_node("PlayerMoveComponent"):
			body.get_node("PlayerMoveComponent").set_physics_process(false)
		
		# Character body not register is_on_floor while being updated via RemoteTransform,
		# so need to exit floor manually
		if body.has_node("FloorActivationComponent"):
			body.get_node("FloorActivationComponent").exit_floor()
		
		
		hit_point = hook_raycast.get_collision_point()
		var hit_collider = hook_raycast.get_collider()
		var hit_direction = body.global_position.direction_to(hit_point)
		
		# YOU CANNOT ADD JOINTS IN RUNTIME
		# That's why have to use PackedScene with Objects and Joint
		# You can delete joints in runtime and modify them
		
		_hook_instance = hook.instantiate() as Node3D
		_rb = _hook_instance.get_node('RigidBody3D') as RigidBody3D
		_sb = _hook_instance.get_node('StaticBody3D') as StaticBody3D
		_joint = _hook_instance.get_node('PinJoint3D') as PinJoint3D
		
		# Clear nodepath to attach bodies later
		_joint.node_a = ''
		_joint.node_b = ''
		
		_sb.add_collision_exception_with(body)
		_rb.add_collision_exception_with(body)
		
		_sb.position = hit_point
		_joint.position = hit_point
		_rb.position = body.global_position + Vector3.UP # Need add offset to not stuck in floor after spawn
		
		body.get_parent().call_deferred('add_child', _hook_instance) # WARN: Add hook to body parent instead of root!
		await _rb.tree_entered
		_rb.apply_central_impulse(hit_direction * base_pull_force) # Move to hitpoint
		
		
		# Remote to pin player to _rb position
		var remote = RemoteTransform3D.new()
		remote.update_rotation = false
		remote.update_scale = false
		remote.update_position = true
		_rb.call_deferred('add_child', remote)
		await remote.tree_entered
		remote.remote_path = body.get_path() # Attach player body to _rb
		
		
		# Temp point position
		var hit_point_node = Node3D.new()
		hit_collider.call_deferred('add_child', hit_point_node)
		await hit_point_node.tree_entered
		hit_point_node.global_position = hit_point
		
		
		var remote_2 = RemoteTransform3D.new()
		remote_2.update_position = true
		remote_2.update_rotation = true
		remote_2.update_scale = false
		hit_point_node.call_deferred('add_child', remote_2)
		
		
		await get_tree().create_timer(free_fly_time).timeout
		# It throws error but works, I don't know why... help
		#_sb.reparent(hit_collider) # Need for non static objects, updates transform of _sb
		
		# UPD fixed with RemoteTransform
		remote_2.remote_path = _sb.get_path() # Need for non static objects, updates transform of _sb
		
		# Activate _joint
		_joint.node_a = _rb.get_path()
		_joint.node_b = _sb.get_path()
		
		grappling = true
	
	if grappling and Input.is_action_just_pressed("forward"):
		var momentum = _rb.linear_velocity.length()
		_hook_instance.call_deferred('queue_free')
		await _hook_instance.tree_exited
		grappling = false
		
		# Give away _rb momentum to player
		velocity_component.last_speed = momentum
		
		# Take back control to PlayerMoveComponent
		if body.has_node("PlayerMoveComponent"):
			body.get_node("PlayerMoveComponent").set_physics_process(true)
