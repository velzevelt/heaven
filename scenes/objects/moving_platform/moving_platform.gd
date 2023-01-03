extends Path3D

@onready var path = $PathFollow3D as PathFollow3D
var reached_end = false

func _physics_process(delta):
	if not reached_end:
		path.progress += delta
	else:
		path.progress -= delta
	
	if path.progress >= 0.99:
		reached_end = true
	elif path.progress <= 0.01 and reached_end:
		reached_end = false
