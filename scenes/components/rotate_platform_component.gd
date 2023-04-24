@tool
class_name RotatePlatformComponent
extends PlatformComponent


@export var rotate_direction: Vector3 = Vector3():
	set(value):
		rotate_direction = value
		if is_instance_valid(platform_body): # Reset rotation
			platform_body.rotation = Vector3()
		update_configuration_warnings()
	get:
		return rotate_direction

@export var angle: float = 0.01

@export var preview_rotation := false:
	set(value):
		preview_rotation = value
		if is_instance_valid(platform_body):
			platform_body.rotation = Vector3()

@export var enabled := true

func _get_configuration_warnings():
	if self.rotate_direction == Vector3.ZERO:
		return ["Need rotate direction"]


func _ready():
	if not enabled:
		return
	
	if not Engine.is_editor_hint() and is_instance_valid(platform_body):
		platform_body.rotation = Vector3()
		preview_rotation = true


func _physics_process(_delta):
	if not enabled:
		return
	
	if is_instance_valid(platform_body) and rotate_direction != Vector3.ZERO and preview_rotation:
		platform_body.rotate(rotate_direction.normalized(), angle)
	elif Engine.is_editor_hint(): # Set platform body to export meta value
		if has_meta("_editor_prop_ptr_platform_body"):
			var temp_path = get_meta("_editor_prop_ptr_platform_body")
			if temp_path != null:
				var temp_platform = get_node_or_null(temp_path)
				if is_instance_valid(temp_platform):
					platform_body = temp_platform
