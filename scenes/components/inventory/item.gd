class_name Item
extends Resource

@export var visible_name: String = ''
@export var name: String = ''
@export var icon = preload("res://icon.svg")
@export var is_consumable := false
@export var is_equippable := false

@export var max_stack_size := 1:
	set(value):
		max_stack_size = value
		if max_stack_size <= 0:
			max_stack_size = 1
	get:
		return max_stack_size

## Item that will be used in scene and handle logic
@export var packed_item: PackedScene
