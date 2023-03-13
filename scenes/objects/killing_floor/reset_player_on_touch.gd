extends KillingFloorTouchHandler

@export var player: Player

@onready var _init_position = player.global_position

func _on_floor_touched(obj):
	player.global_position = _init_position
	player.get_node("VelocityComponent").last_speed = 1.0
