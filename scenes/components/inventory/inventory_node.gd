class_name InventoryNode
extends Node

@export var inventory_res: Inventory = Inventory.new()
@export var test_item: Item = Item.new()

func _ready():
	inventory_res.add_item(test_item)
	inventory_res.add_item(test_item)
	inventory_res.add_item(test_item)
	
	for t in inventory_res.slots:
		if t.item != null:
			print(t.item.name, t.in_stack)
