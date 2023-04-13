extends Node3D

@export var destination: Node3D
@export var player_cam: Camera3D

@onready var portal_viewport: SubViewport = $PortalViewport
@onready var portal_mesh: MeshInstance3D = $MeshInstance3D
@onready var material: ShaderMaterial = portal_mesh.get_active_material(0)

@onready var screen_texture: ViewportTexture = portal_viewport.get_texture():
	get:
		return portal_viewport.get_texture()

var _traveller: Node3D


func _on_area_3d_body_entered(body):
	if body.is_in_group('player'):
		Logger.debug_log('teleporting...')
		
#		traveller = body
#		traveller.velocity = Vector3.ZERO
#		traveller.global_transform = destination.global_transform



func _ready():
	portal_viewport.size = get_tree().root.size
	portal_viewport.get_camera_3d().fov = player_cam.fov


func _physics_process(_delta):
	material.set_shader_parameter('texture_albedo', screen_texture)
