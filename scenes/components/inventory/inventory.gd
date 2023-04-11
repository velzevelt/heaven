class_name Inventory
extends Resource

@export var pocket_size := 3
@export var size := 6

var slots: Array[Slot] = _reset_slots()

func _reset_slots():
	slots.clear()
	
	for i in pocket_size:
		var slot = Slot.new()
		slot.is_pocket = true
		slot.item = null
		slots.append(slot)
	
	for i in size:
		var slot = Slot.new()
		slot.is_pocket = false
		slot.item = null
		slots.append(slot)


func add_item(item):
	if not has_free_slot():
		return null
	
	# At first, loop through slots with this item to add it to stack
	for slot in slots:
		if slot.item == item and not slot.is_full:
			slot.in_stack += 1
			break
	
	# At second, loop through remaining slots and add it to free slot
	for slot in slots:
		if slot.item == null:
			slot.item = item
			slot.in_stack = 1
			break


#func get_free_slot() -> Slot:
#	if not has_free_slot():
#		return null
#	else:
#		# At first, loop through slots with this item to add it to stack
		


func has_free_slot() -> bool:
	return slots.any(func(slot): not slot.is_full)


class Slot:
	## Means player can switch to that slot using Input actions
	var is_pocket := false
	var item = null
	
	var in_stack := 0:
		set(value):
			in_stack = value
			if in_stack < 0:
				in_stack = 0
		get:
			return in_stack
	
	## Slot cannot has new items anymore
	var is_full: bool = false:
		get:
			if not is_instance_valid(item):
				return false
			
			return in_stack < item.max_stack_size


	#! Put this in separate resource script
	class Item:
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
