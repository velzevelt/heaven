extends Node3D



func _on_area_3d_body_entered(body):
	if body is Player:
		Logger.debug_log('Player was killed by thorn')
		Logger.debug_log('Reloading current scene...')
		get_tree().reload_current_scene()
