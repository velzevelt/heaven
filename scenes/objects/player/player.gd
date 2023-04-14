class_name Player 
extends CharacterBody3D

@onready var init_position = self.global_position

var on_floor: 
	get: return is_on_floor()
