class_name Item
extends Resource

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

## Item that will be used in scene
@export var packed_item: PackedScene

## Reference to instance of packed_item
var item_node

@export var is_consumable := false
@export var is_equippable := false


func instantiate_item():
	var res = packed_item.instantiate()
	item_node = res
	return res
