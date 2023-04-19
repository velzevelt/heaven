@tool
extends CollisionShape3D

@export var update_shape := false:
	set(_value):
		var mesh_shape = $"../MeshInstance3D" as MeshInstance3D
		shape.size = mesh_shape.mesh.size
	get:
		return update_shape
