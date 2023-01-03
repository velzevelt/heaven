extends Node3D


func _on_area_3d_body_entered(body):
	if body is Player:
		
		Logger.debug_log("I'm a happy coin")
		
		self.call_deferred('free')
