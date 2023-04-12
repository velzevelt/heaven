extends Camera3D

@export var portal: Node3D
@export var portal_mesh: MeshInstance3D
@export var player_cam: Camera3D
@export var sub_viewport: SubViewport

@onready var material: ShaderMaterial = portal_mesh.get_active_material(0)
@onready var init_global_transform = global_transform

@onready var screen_texture: ViewportTexture = sub_viewport.get_texture():
	get:
		return sub_viewport.get_texture()


func _process(delta):
	var m = init_global_transform * player_cam.global_transform * portal.global_transform as Transform3D
#	m.basis = m.basis.rotated(Vector3.RIGHT, deg_to_rad(-180))
	global_transform.basis = m.basis


func _physics_process(_delta):
	material.set_shader_parameter('albedo', screen_texture)
