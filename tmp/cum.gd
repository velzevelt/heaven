extends Camera3D

@export var player: Player

func _process(delta):
	global_position += player.global_position
