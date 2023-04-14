extends Node

@export var door: DoorRigidBody3D
@export var key_item: Item


#func _on_area_3d_body_entered(body):
#	if body.is_in_group('player') and body.has_node('InventoryNode'):
#		var inventory = body.get_node('InventoryNode').inventory_res as Inventory
#		if inventory.has_item(key_item):
#			door.closed = false

func _ready():
	Events.item_added.connect(open_door)

func open_door(item):
	if item == key_item:
		door.closed = false
