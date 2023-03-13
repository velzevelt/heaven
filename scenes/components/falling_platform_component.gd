@tool
class_name FallingPlatformComponent 
extends PlatformComponent

signal fall_started
signal fell

@export var live_time := 10.0
@export var autofall := false


func _ready():
	super()
	if autofall:
		start_falling()



func _on_object_entered(_player):
	start_falling()


func start_falling():
	fall_started.emit()
	await get_tree().create_timer(live_time).timeout
	fell.emit()
	Logger.debug_log('Platform has fallen')
