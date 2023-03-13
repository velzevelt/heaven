extends KillingFloorTouchHandler


func _on_floor_touched(obj: CharacterBody3D):
	Logger.debug_log("Reloading current scene...")
	SceneLoader.reload_scene()
	
