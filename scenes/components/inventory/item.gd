class_name Item
extends Resource

signal item_used


@export var visible_name: String = ''
@export var name: String = ''
@export var icon = preload("res://icon.svg")

@export var max_stack_size := 1:
	set(value):
		max_stack_size = value
		if max_stack_size <= 0:
			max_stack_size = 1
	get:
		return max_stack_size

@export var in_stack := 1:
	set(value):
		in_stack = value
		if in_stack <= 0:
			in_stack = 0
	get:
		return in_stack

## Item that will be used in scene
@export var packed_item: PackedScene


@export var is_consumable := false
@export var is_equippable := false
