extends Node

@onready var timer = $Timer as Timer
@onready var area = $Area3D as Area3D

func finish():
	Logger.debug_log("Player finished level!")


func _on_area_3d_body_entered(body):
	if body is Player:
		# Player can fall from this platform, we must be sure he stands still
		if body.velocity == Vector3.ZERO:
			finish()
		else:
			timer.start(1)
			await timer.timeout
			# This needs for better accurancy
			if area.overlaps_body(body):
				_on_area_3d_body_entered(body)



