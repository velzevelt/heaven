extends Sprite3D

@onready var _raycast = get_parent() as RayCast3D


func _physics_process(_delta):
	if _raycast.is_colliding():
		var point = _raycast.get_collision_point()
		
		self.global_position = point
		self.visible = true
	else:
		self.visible = false
