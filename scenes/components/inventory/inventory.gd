class_name Inventory
extends Resource

## Inventory is full, items cannot be added
const ERR_HAVE_NO_SPACE = 1

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
	
	return slots


func add_item(item: Item) -> Error:
	if not has_free_slot():
		@warning_ignore("int_as_enum_without_cast")
		return ERR_HAVE_NO_SPACE
	
	# At first, loop through slots with this item to add it to stack
	for slot in slots:
		if slot.item == item and not slot.is_full:
			slot.in_stack += 1
			return OK
	
	# At second, loop through remaining slots and add it to free slot
	for slot in slots:
		if slot.item == null:
			slot.item = item
			slot.in_stack = 1
			return OK
	
	return ERR_BUG


func has_free_slot() -> bool:
	return slots.any(func(slot): return not slot.is_full)


class Slot:
	## Means player can switch to that slot using Input actions
	var is_pocket := false
	var item: Item = null
	
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
			
			return in_stack >= item.max_stack_size
	
