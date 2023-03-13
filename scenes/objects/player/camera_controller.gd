class_name Head extends Node3D

@onready var jump_point = $%JumpPoint

var mouse_sensitivity = ProjectSettings.get_setting("display/mouse_cursor/sensitivity")

#func _input(event):
#	if event is InputEventMouseMotion:
#		owner.rotate_y(  deg_to_rad( -event.relative.x * mouse_sensitivity ) )
#		self.rotate_x( deg_to_rad( -event.relative.y * mouse_sensitivity ) )
#		self.rotation.x = clamp( self.rotation.x, deg_to_rad(-90), deg_to_rad(90) )
#

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		owner.rotate_y(  deg_to_rad( -event.relative.x * mouse_sensitivity ) )
		self.rotate_x( deg_to_rad( -event.relative.y * mouse_sensitivity ) )
		self.rotation.x = clamp( self.rotation.x, deg_to_rad(-90), deg_to_rad(90) )


func get_jump_direction() -> Vector3:
	return self.global_position.direction_to(jump_point.global_position)
