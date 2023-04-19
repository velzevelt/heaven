class_name MapGoalData
extends Resource

signal goal_completed(goal_data)

@export var visible_name: String = '': # e.g. Collect all coins
	get:
		return tr(visible_name)

@export_multiline var goal_description: String = '':
	get:
		return tr(goal_description)

@export var completed := false: 
	set(value):
		completed = value
		if completed:
			Events.goal_completed.emit(self)
			goal_completed.emit(self)
	get:
		return completed

var progress: String = '' # Formatted string
