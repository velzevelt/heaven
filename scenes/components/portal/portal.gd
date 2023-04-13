class_name Portal
extends Node

@export var destination: Node3D
@export var player_camera: Camera3D

@onready var portal_viewport: SubViewport = $PortalViewport
@onready var portal_camera: Camera3D = portal_viewport.get_camera_3d()
@onready var holder: Node3D = portal_camera.get_parent()
@onready var portal_mesh: MeshInstance3D = $MeshInstance3D
@onready var material: ShaderMaterial = portal_mesh.get_active_material(0)

@onready var screen_texture: ViewportTexture = portal_viewport.get_texture():
	get:
		return portal_viewport.get_texture()

var _traveller: Node3D


func _ready():
	portal_camera.fov = player_camera.fov
	sync_viewport()
	get_tree().root.size_changed.connect(sync_viewport)


func _physics_process(_delta):
	material.set_shader_parameter('texture_albedo', screen_texture)
	move_camera()


func _on_area_3d_body_entered(body):
	if body.is_in_group('player'):
		Logger.debug_log('teleporting...')


func sync_viewport() -> void:
	portal_viewport.size = get_tree().root.size


func move_camera() -> void:
	var transform: Transform3D = destination.global_transform.inverse() * portal_camera.global_transform
#	transform = transform.rotated(Vector3.UP, PI)
	holder.transform = transform
	
	var cam_pos: Transform3D = holder.global_transform
	portal_camera.global_transform = cam_pos
