class_name MapGoal
extends Resource

@export var visible_name: String = '' # e.g. Collect all coins
@export_multiline var goal_description: String = '' # e.g. You need to collect %d coins from this level
@export var completed := false


@export var reward: Script
