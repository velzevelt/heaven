@tool
extends CollisionShape3D

#@export var size = 0.1

@export var update_shape := false:
	set(_value):
		@warning_ignore("shadowed_variable_base_class")
		var shape = self.shape as BoxShape3D
		shape.size = $"../MeshInstance3D".mesh.size
	get:
		return update_shape
