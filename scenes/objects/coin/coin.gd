class_name Coin 
extends Node3D

signal picked_up

@export var enabled := true

func _ready():
	self.picked_up.connect(_on_pickup)


func _on_area_3d_body_entered(body):
	if enabled:
		if body.is_in_group('player'):
			Events.object_picked_up.emit(self)
			picked_up.emit()


func _on_pickup():
	Logger.debug_log("I'm a happy coin")
	call_deferred('queue_free')
