class_name CollectNodeGoal
extends Node

signal goal_completed(goal_data, goal_node)

@export var map_goal_data: MapGoalData

@export var target_group: String
var target_count := 0
var max_target_count := 0



func _ready():
	map_goal_data = map_goal_data.duplicate()
	
	get_tree().node_added.connect(_on_node_added)
	get_tree().node_removed.connect(_on_node_removed)
	Events.object_picked_up.connect(_on_object_picked_up)
	max_target_count = get_tree().get_nodes_in_group(target_group).size()
	
	map_goal_data.progress = "%d/%d" % [target_count, max_target_count]


func _on_node_added(node):
	if node.is_in_group(target_group):
		max_target_count += 1


func _on_node_removed(node):
	if node.is_in_group(target_group):
		max_target_count -= 1


func _on_object_picked_up(obj):
	if obj.is_in_group(target_group):
		target_count += 1
		map_goal_data.progress = "%d/%d" % [target_count, max_target_count]
		
		
		if target_count == max_target_count:
			Logger.debug_log('All collected!')
			map_goal_data.completed = true
			goal_completed.emit(map_goal_data, self)
			
