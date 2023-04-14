extends Node

@export var door: DoorRigidBody3D
@export var key_item: Item
@export var closed_label: Label


func _ready():
	Events.item_added.connect(open_door)
	closed_label.visible = false


func open_door(item):
	if item == key_item:
		door.closed = false


func _on_physics_door_interaction_begin():
	if door.closed:
		closed_label.visible = true
		await get_tree().create_timer(2.0).timeout
		closed_label.visible = false

func _on_physics_door_interaction_end():
	closed_label.visible = false
