extends Node


func finish():
	Logger.debug_log("Player finished level!")


func _on_area_3d_body_entered(body):
	if body is Player:
		# Player can fall from finish, we must be sure he stands still
		if body.velocity == Vector3.ZERO:
			finish()
		else:
			var t = get_tree().create_timer(1)
			await t.timeout
			_on_area_3d_body_entered(body)


func _on_timer_timeout():
	#
	pass
