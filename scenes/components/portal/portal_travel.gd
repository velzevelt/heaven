extends Node3D

@export var destination: Node3D

var traveller: Node3D


func _on_area_3d_body_entered(body):
	if body.is_in_group('player'):
		Logger.debug_log('teleporting...')
		
		traveller = body
		traveller.velocity = Vector3.ZERO
		traveller.global_transform = destination.global_transform


func _on_visible_on_screen_notifier_3d_screen_exited():
	Logger.debug_log('123123')
