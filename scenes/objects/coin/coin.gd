class_name Coin 
extends Node3D

signal picked_up


func _ready():
	self.picked_up.connect(_on_pickup)


func _on_area_3d_body_entered(_body):
	picked_up.emit()
	Events.object_picked_up.emit(self)


func _on_pickup():
	Logger.debug_log("I'm a happy coin")
	queue_free()
