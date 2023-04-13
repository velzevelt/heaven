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

@onready var init_transform: Transform3D = self.global_transform


func _ready():
	portal_camera.fov = player_camera.fov
	sync_viewport_size()
	get_tree().root.size_changed.connect(sync_viewport_size)


func _physics_process(_delta):
	material.set_shader_parameter('texture_albedo', screen_texture)
	holder.global_rotation = player_camera.global_rotation


func sync_viewport_size() -> void:
	portal_viewport.size = get_tree().root.size
	


func teleport(body):
	Logger.debug_log('teleporting...')
#	body.global_transform = destination.global_transform
	body.global_position = destination.global_position
	body.velocity = -destination.global_transform.basis.z * body.velocity.length()


func _on_area_3d_area_entered(area):
	if area.is_in_group('player'):
		var player = area.get_parent().get_parent()
		var player_view_texture = player_camera.get_viewport().get_texture()
		player_view_texture.get_image().save_png('res://tmp/portal.png')
		
#		teleport(player)
