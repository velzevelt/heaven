extends Node

@export var hook_raycast: RayCast3D

## Scene with RigidBody3D, StaticBody3D and PinJoint3D connected between them
@export var hook: PackedScene = preload("res://scenes/objects/player/hook.tscn")

## Player body
@export var body: CharacterBody3D

@export var velocity_component: VelocityComponent

## Determine force of engagement to hit_point
@export var base_pull_force: float = 15.0

## Determine how long body be free untill it attached to joint
@export var free_fly_time := 0.4

## Specific Input
#@export var input_component: GrapplingHookInputComponent


var hit_point: Vector3 = Vector3()
var grappling := false

var _remote: RemoteTransform3D

func _physics_process(_delta):
	if hook_raycast.is_colliding() and Input.is_action_just_pressed("forward") and not grappling:
		grappling = true
		
		hit_point = hook_raycast.get_collision_point()
		var hit_collider = hook_raycast.get_collider()
		var hit_direction = body.global_position.direction_to(hit_point)
		
		
		# YOU CANNOT ADD JOINTS IN RUNTIME
		# That's why have to use PackedScene with Objects and Joint
		# You can delete joints in runtime and modify them
		
		var instance = hook.instantiate() as Node3D
		var rb = instance.get_node('RigidBody3D') as RigidBody3D
		var sb = instance.get_node('StaticBody3D') as StaticBody3D
		var joint = instance.get_node('PinJoint3D') as PinJoint3D
		
		# Clear nodepath to attach bodies later
		joint.node_a = ''
		joint.node_b = ''
		
		sb.add_collision_exception_with(body)
		rb.add_collision_exception_with(body)
		
		sb.position = hit_point
		joint.position = hit_point
		rb.position = body.global_position + Vector3.UP # Need add offset to not stuck in floor after spawn
		
		body.get_parent().call_deferred('add_child', instance)
		await rb.tree_entered
		rb.apply_central_impulse(hit_direction * base_pull_force) # Move to hitpoint
		
		_remote = RemoteTransform3D.new()
		_remote.update_rotation = false
		_remote.update_scale = false
		_remote.update_position = true
		rb.call_deferred('add_child', _remote)
		await _remote.tree_entered
		_remote.remote_path = body.get_path() # Attach player body to rb
		
		
		await get_tree().create_timer(free_fly_time).timeout
		# It throws error but works, I don't know why... help
		sb.reparent(hit_collider) # Need for non static objects, updates transform of sb
		
		# Activate joint
		joint.node_a = rb.get_path()
		joint.node_b = sb.get_path()
	
	if grappling and Input.is_action_just_pressed("forward"):
		print(1)
