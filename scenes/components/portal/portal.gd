class_name Portal
extends Node

@export var destination: Node3D
@export var portal_viewport: SubViewport

@onready var area: Area3D = $Area3D
@onready var player_camera: Camera3D = get_tree().root.get_camera_3d()
@onready var portal_camera: Camera3D = portal_viewport.get_camera_3d()
@onready var holder: Node3D = portal_camera.get_parent()
@onready var portal_mesh: MeshInstance3D = $MeshInstance3D
@onready var material: ShaderMaterial = portal_mesh.get_active_material(0)

@onready var screen_texture: ViewportTexture = portal_viewport.get_texture():
	get:
		return portal_viewport.get_texture()

@onready var init_position: Vector3 = destination.global_transform.origin
@onready var player = player_camera.get_parent().get_parent()


func _ready():
	portal_camera.fov = player_camera.fov
	sync_viewport_size()
	get_tree().root.size_changed.connect(sync_viewport_size)


func _physics_process(_delta):
	material.set_shader_parameter('texture_albedo', screen_texture)
	
	portal_camera.global_rotation = player_camera.global_rotation
	portal_camera.fov = player_camera.fov
	

func sync_viewport_size() -> void:
	portal_viewport.size = get_tree().root.size
	


func teleport(body):
	Logger.debug_log('teleporting...')
#	portal_camera.fov = player_camera.fov
#	await RenderingServer.frame_post_draw

	body.global_position = destination.global_position


func _on_area_3d_area_entered(area):
	if area.is_in_group('player'):
		var player = area.get_parent().get_parent()
		
		teleport(player)
