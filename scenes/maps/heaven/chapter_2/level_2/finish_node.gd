extends Node

@export var targets: Array 
var _passed_targets: Array 

func _on_csg_box_3d_5_object_entered(obj):
	if obj in targets:
		_passed_targets.append(obj)


func _check_finish():
	return _passed_targets.size() == targets.size()


func _on_csg_box_3d_5_object_exited(obj):
	if obj in _passed_targets:
		_passed_targets.erase(obj)
