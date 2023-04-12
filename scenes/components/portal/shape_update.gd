@tool
extends CollisionShape3D

@export var update_shape := false:
	set(value):
		var mesh = $"../../MeshInstance3D"
		mesh = mesh.mesh as BoxMesh
		var shape = self.shape as BoxShape3D
		shape.size = mesh.size
	get:
		return update_shape
