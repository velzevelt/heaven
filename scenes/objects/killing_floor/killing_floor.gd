extends Node3D

signal floor_touched

func _on_area_3d_body_entered(body):
	if body is Player:
		floor_touched.emit()
		Logger.debug_log('Reloading current scene...')
		get_tree().reload_current_scene()
