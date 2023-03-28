extends Node

signal player_target_spotted(override_crosshair)
signal player_target_losted(override_crosshair)


signal player_finished


signal object_picked_up(object)

signal goal_completed(goal_data)


# debug signals
func _ready():
	player_finished.connect(func(): Logger.debug_log("Player finished level!"))
	
