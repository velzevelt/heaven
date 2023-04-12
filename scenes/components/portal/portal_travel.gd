extends Node3D

@export var destination: Node3D

var traveller


func _on_area_3d_body_entered(body):
	if body.is_in_group('player'):
		Logger.debug_log('player -123')
		traveller = body
		traveller.global_position = destination.global_position
