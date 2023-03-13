extends Node3D

signal finished

@onready var targets_qty = get_child_count()
var activated_targets: Array = []

func _ready():
	for c in get_children():
		c.activated.connect(_on_activated)

func _on_activated(object):
	if object not in activated_targets:
		activated_targets.append(object)
		if activated_targets.size() == targets_qty:
			await get_tree().create_timer(2.0).timeout
			finished.emit()
