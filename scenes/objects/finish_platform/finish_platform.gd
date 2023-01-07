extends Platform

signal finished

@onready var timer = $Timer as Timer


func _on_area_3d_body_entered(body):
	if body is Player:
		player_entered.emit()
		
		# Player can fall from this platform, we must be sure he stands still
		if body.velocity == Vector3.ZERO:
			finished.emit()
			Logger.debug_log("Player finished level!")
		else:
			timer.start(1)
			await timer.timeout
			# Refreshing area
			if area.overlaps_body(body):
				_on_area_3d_body_entered(body)



