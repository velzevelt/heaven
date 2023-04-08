extends RayCast3D


func _physics_process(_delta):
	if is_colliding():
		var collider = get_collider()
		if collider.is_in_group('door'):
			print('Door spotted')
		elif collider.is_in_group('item'):
			pass
