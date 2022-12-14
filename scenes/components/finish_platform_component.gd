class_name FinishPlatformComponent
extends PlatformComponent
@tool

signal finished

@onready var timer = Timer.new()


func _initialize():
	super()
	add_child(timer)


func _on_area_3d_body_entered(body):
	super(body)
	
	if body is Player:
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



