class_name MapGoalStorage
extends Node

var goals: Array[MapGoalData]:
	get:
		goals.clear()
		for c in get_children():
			if c.get('map_goal_data') != null:
				goals.append(c.map_goal_data)
		return goals


var max_completed_count:
	get:
		return goals.size()


var completed_count := 0


func _ready():
	var goals = get_children()
	
	for goal in goals:
		if goal.get('map_goal_data') != null:
			goals.append(goal.map_goal_data)
