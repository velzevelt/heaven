class_name InventoryNode
extends Node

signal item_added(item)
signal inventory_overflowed

@export var inventory_menu: PackedScene # preload(...)
@export var inventory_res: Inventory = Inventory.new()

var _inventory_menu_instance

@export var test_item: Item

func _ready():
	Events.object_picked_up.connect(_on_object_picked_up)
	

func _debug_slot_data():
	for slot in inventory_res.slots:
		if slot.item:
			print([slot.in_stack, slot.item.max_stack_size, slot.is_full, slot.item.name])
		else:
			print('null')

func _on_object_picked_up(object):
	if object.get('item') != null:
		var error = inventory_res.add_item(object.item)
		match error:
			Inventory.ERR_HAVE_NO_SPACE, Inventory.ERR_ADD_INCOMPLETE:
				inventory_overflowed.emit()
			ERR_BUG:
				Logger.debug_log('Unknown error in inventory occured', MESSAGE_TYPE.ERROR)
			OK:
				item_added.emit(object.item)
	else:
		Logger.debug_log('Failed to add_item on %s, make sure that it has item resource if it was not intended' % object.name, MESSAGE_TYPE.WARNING)


func _unhandled_input(_event):
	if Input.is_action_just_pressed('open_inventory') and not is_instance_valid(_inventory_menu_instance):
		_inventory_menu_instance = inventory_menu.instantiate()
		inventory_menu.inventory_res = self.inventory_res
		
		### Make mouse visible when inventory_menu appeared, resume when closed
		
		inventory_menu.call_deferred('_early_ready') # Create slots here
		call_deferred('add_child', inventory_menu)
