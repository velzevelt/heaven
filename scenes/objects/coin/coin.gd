class_name Coin extends Node3D

signal picked_up

func _ready():
	self.picked_up.connect(_on_pickup)

func _on_area_3d_body_entered(body):
	picked_up.emit()

func _on_pickup():
	Logger.debug_log("I'm a happy coin")
	queue_free()
