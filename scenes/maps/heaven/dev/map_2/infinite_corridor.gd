extends Node

@export var player: Node3D

@export var top_part: Node3D
@export var central_part: Node3D
@export var back_part: Node3D

@export var corridor_length = 20
var new_origin = corridor_length


func _physics_process(_delta):
	if player.global_position.x > new_origin:
		if player.global_position.x > 0:
			back_part.global_position.x = top_part.global_position.x * 2
			new_origin = back_part.global_position.x
			
			var swap = back_part
			back_part = central_part
			central_part = swap
