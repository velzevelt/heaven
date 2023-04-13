class_name InventoryNode
extends Node

signal inventory_changed(new_inventory)
signal item_added(item)
signal inventory_overflowed

@export var inventory_menu: PackedScene # preload(...)
@export var inventory_res: Inventory = Inventory.new()

var _inventory_menu_instance


func _ready():
	Events.object_picked_up.connect(_on_object_picked_up)
	
	item_added.connect(func(_p): _debug_inventory_slots())
	inventory_overflowed.connect(func(): _debug_inventory_slots())


func _debug_inventory_slots():
	var i = 0
	for slot in inventory_res.slots:
		if slot.item:
			print([i, slot.in_stack, slot.item.max_stack_size, slot.is_full, slot.item.name])
		else:
			print([i, null])
		i += 1


func _on_object_picked_up(object):
	if object.get('item') != null:
		if object.item is Item:
			var error = inventory_res.add_item(object.item)
			match error:
				Inventory.ERR_HAVE_NO_SPACE, Inventory.ERR_ADD_INCOMPLETE:
					inventory_overflowed.emit()
				OK:
					item_added.emit(object.item)
					inventory_changed.emit(inventory_res)
		else:
			Logger.debug_log('%s: Item cast failed, wrong .tres?' % object.name, MESSAGE_TYPE.ERROR)
	else:
		Logger.debug_log('Failed to add_item on %s, make sure that it has item resource if it was not intended' % object.name, MESSAGE_TYPE.WARNING)


func _unhandled_input(_event):
	if Input.is_action_just_pressed('open_inventory') and not is_instance_valid(_inventory_menu_instance):
		_inventory_menu_instance = inventory_menu.instantiate()
		inventory_menu.inventory_res = self.inventory_res
		
		### Make mouse visible when inventory_menu appeared, resume when closed
		
		inventory_menu.call_deferred('_early_ready') # Create UI for slots here
		call_deferred('add_child', inventory_menu)
