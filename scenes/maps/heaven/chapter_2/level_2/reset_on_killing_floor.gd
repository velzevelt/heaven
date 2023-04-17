extends Node

@export var vert_offset := 10

@onready var parent: RigidBody3D = get_parent()
@onready var init_position = parent.global_position


func _on_killing_floor_floor_touched(obj):
	if obj == parent:
		obj.global_position = init_position
		obj.position.y += vert_offset
		obj.linear_velocity = Vector3.ZERO
