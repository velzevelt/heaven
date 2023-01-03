extends Path3D

@onready var path = $PathFollow3D as PathFollow3D
var reached_end = false

func _physics_process(delta):
	if not reached_end:
		path.progress += delta
	else:
		path.progress -= delta
	
	if path.progress == 1:
		reached_end = true
