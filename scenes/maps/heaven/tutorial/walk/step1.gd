extends Node3D

@export var finish: Node

func _on_area_3d_body_entered(body):
	if body.is_in_group('player'):
		finish.visible = true
		finish.enabled = true
