class_name BouncePlatformComponent
extends PlatformComponent
@tool

@export var jump_force := 10.0

func _on_area_3d_body_entered(body):
	super(body)
	
	if body is Player:
		var player = body as Player
		player.jump(jump_force)
