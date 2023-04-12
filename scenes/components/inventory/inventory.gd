class_name Inventory
extends Resource

## Inventory is full, items cannot be added
const ERR_HAVE_NO_SPACE = 1

## Some items were added, but inventory overfloawed during process
const ERR_ADD_INCOMPLETE = 2


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
	
	
	# At first, loop through slots with current item and add it to stack
	for slot in slots:
		if slot.item == item and not slot.is_full:
			var new_stack = slot.in_stack + item.in_stack
			
			if new_stack > item.max_stack_size:
				new_stack -= item.max_stack_size
				item.in_stack -= new_stack
				slot.in_stack += new_stack
				
				if has_free_slot():
					continue
				else:
					@warning_ignore("int_as_enum_without_cast")
					return ERR_ADD_INCOMPLETE
			
			slot.in_stack += item.in_stack
			return OK
	
	# At second, loop through remaining slots and add it to free slot
	for slot in slots:
		if slot.item == null:
			slot.item = item
			
			if item.in_stack > item.max_stack_size:
				item.in_stack -= item.max_stack_size
				slot.in_stack = item.max_stack_size
				
				if has_free_slot():
					continue
				else:
					@warning_ignore("int_as_enum_without_cast")
					return ERR_ADD_INCOMPLETE
			
			slot.in_stack = item.in_stack
			return OK
	
	Logger.debug_log('Unkown error in add_item', MESSAGE_TYPE.ERROR)
	return ERR_BUG


func has_free_slot() -> bool:
	return slots.any(func(slot): return not slot.is_full)

## Update position or any properties after calling this method
func throw_item_from(slot: Slot) -> Node:
	var instance = slot.item.item_behaviour.instantiate()
	
	# Update in_stack before clearing slot to not lose items in stack
	slot.item.in_stack = slot.in_stack
	slot.instance.item = slot.item
	
	if instance.has_method('_on_throwed_away'):
		instance.callv('_on_throwed_away', [self, slot, slot.item])
	
	slot.clear() # Throw away whole stack instead of just one item
	return instance


class Slot:
	## Means player can switch to that slot using Input actions
	var is_pocket := false
	
	var item: Item = null
	
	var in_stack := 0:
		set(value):
			in_stack = value
			if in_stack <= 0:
				clear()
		get:
			return in_stack
	
	var is_full: bool = false:
		get:
			if not is_instance_valid(item):
				return false
			
			return in_stack >= item.max_stack_size
	
	func clear() -> void:
		in_stack = 0
		item = null
