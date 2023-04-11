class_name InventoryNode
extends Node

signal item_added(item)
signal inventory_overflowed

@export var inventory_menu: PackedScene # preload(...)
@export var inventory_res: Inventory = Inventory.new()


func _ready():
	Events.object_picked_up.connect(_on_object_picked_up)


func _on_object_picked_up(object):
	if object.get('item') != null:
		var error = inventory_res.add_item(object.item)
		match error:
			Inventory.ERR_HAVE_NO_SPACE:
				inventory_overflowed.emit()
			ERR_BUG:
				Logger.debug_log('Unknown error in inventory occured', MESSAGE_TYPE.ERROR)
			OK:
				item_added.emit(object.item)
	else:
		Logger.debug_log('Failed to add_item on %s, make sure that it has item resource if it was not intended' % object.name, MESSAGE_TYPE.WARNING)
