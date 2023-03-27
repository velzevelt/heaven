class_name CompleteInTimeGoal
extends Node

signal goal_completed(goal_data, goal_node)

@export var map_goal_data: MapGoalData
@export var timer: VelzTimer
@export var required_time: VelzTime

func _ready():
	map_goal_data = map_goal_data.duplicate()
	map_goal_data.visible_name = map_goal_data.visible_name.format({'time': required_time.get_vector()})
	
	Events.player_finished.connect(_on_player_finished)


func _on_player_finished():
	complete_check()


func complete_check():
	if timer.time.get_vector().length() <= required_time.get_vector().length():
		map_goal_data.completed = true
		goal_completed.emit(map_goal_data, self)
	else:
		map_goal_data.progress = "Your time: %s . Required time: %s" % [timer.time.get_vector(), required_time.get_vector()]
		map_goal_data.completed = false

