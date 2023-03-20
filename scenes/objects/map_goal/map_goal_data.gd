class_name MapGoalData
extends Resource

signal goal_completed(goal_data)

@export var visible_name: String = '' # e.g. Collect all coins
@export_multiline var goal_description: String = '' # e.g. You need to collect %d coins from this level
@export var completed := false: 
	set(value):
		completed = value
		if completed:
			Events.goal_completed.emit(self)
			goal_completed.emit(self)
	get:
		return completed

