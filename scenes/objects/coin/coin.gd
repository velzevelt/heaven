class_name Coin extends Node3D

signal picked_up


func _on_area_3d_body_entered(body):
	if body is Player:
		picked_up.emit()
		_on_pickup()


func _on_pickup():
	Logger.debug_log("I'm a happy coin")
	queue_free()
