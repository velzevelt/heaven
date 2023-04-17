extends KillingFloorTouchHandler


func _on_floor_touched(obj):
	if obj.is_in_group('player'):
		Logger.debug_log("Reloading current scene...")
		SceneLoader.reload_scene()
	
