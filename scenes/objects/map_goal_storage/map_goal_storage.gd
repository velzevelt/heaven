class_name MapGoalStorage
extends Node

var goals: Array[MapGoalData]:
	get:
		goals.clear()
		for c in get_children():
			if c.get('map_goal_data') != null:
				goals.append(c.map_goal_data)
		return goals
