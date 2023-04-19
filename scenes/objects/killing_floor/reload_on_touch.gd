extends KillingFloorTouchHandler


func _on_floor_touched(obj):
	if obj.is_in_group('player'):
		SceneLoader.reload_scene()
	
