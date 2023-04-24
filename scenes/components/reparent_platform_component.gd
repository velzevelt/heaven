class_name ReparentPlatformComponent
extends PlatformComponent

@export var target_groups: PackedStringArray = ['player']
@export var new_parent: Node3D
@export var enabled := true
#@export var override_motion_mode := true

var _player
var _prev_parent

func _ready():
	super()
	platform_body.object_entered_strict.connect(_on_object_entered_strict)

func _on_object_entered_strict(obj):
	if not enabled:
		return
	
	if obj.get_groups().any(func(group): return group in target_groups) :
		_player = obj
		_prev_parent = _player.get_parent()
		_player.reparent(new_parent)
		var tween_rotation = create_tween()
		tween_rotation.tween_property(_player, 'rotation', Vector3(0, _player.rotation.y, 0), 0.1)
		
		# After reparent FloorActivationComponent immediately calls object_exited. Need wait 2 frames to avoid this
		_add_delay()


func _on_object_exited(obj):
	if not enabled:
		return
	
	if obj == _player and is_instance_valid(_prev_parent):
		_player.reparent(_prev_parent)
		var tween_rotation = create_tween()
		tween_rotation.tween_property(_player, 'global_rotation', Vector3(0, _player.rotation.y, 0), 0.1)
		# After reparent FloorActivationComponent may call object_entered. Need wait 2 frames to avoid this
		_add_delay()



func _add_delay():
	if _player.has_node("FloorActivationComponent"):
		_player.get_node("FloorActivationComponent").set_physics_process(false)
		await get_tree().physics_frame
		await get_tree().physics_frame
		_player.get_node("FloorActivationComponent").set_physics_process(true)
