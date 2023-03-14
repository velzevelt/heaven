class_name KillingFloorTouchHandler
extends Node

func _ready():
	get_parent().connect('floor_touched', _on_floor_touched)

func _on_floor_touched(_obj):
	pass
