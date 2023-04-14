extends KillingFloorTouchHandler


func _on_floor_touched(_obj):
	if _obj.is_in_group('player'):
		var player = _obj as Player
		player.global_position = player.init_position
		player.velocity = Vector3.ZERO
