@tool
extends MeshInstance3D

@export var preview_portal := true
@export var sub_viewport: SubViewport

var screen_texture: ViewportTexture = ViewportTexture.new():
	get:
		if Engine.is_editor_hint():
			var t = get_node_or_null(get_meta("_editor_prop_ptr_sub_viewport"))
			if preview_portal and is_instance_valid(t):
				return t.get_texture()
			else:
				return screen_texture # null
		else:
			return sub_viewport.get_texture()

@onready var material: StandardMaterial3D = self.get_active_material(0)


func _physics_process(_delta):
	if Engine.is_editor_hint():
		if preview_portal:
			material.albedo_texture = screen_texture
	else:
		material.albedo_texture = screen_texture
