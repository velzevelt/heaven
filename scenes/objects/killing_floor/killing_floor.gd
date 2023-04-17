extends Node3D

signal floor_touched(obj)


func _on_area_3d_body_entered(body):
	floor_touched.emit(body)
