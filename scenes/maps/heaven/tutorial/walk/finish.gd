extends Node3D

@export var enabled := true



func _on_area_3d_body_entered(body):
	if body.is_in_group('player') and enabled:
		Events.player_finished.emit()
