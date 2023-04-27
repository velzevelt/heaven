#class_name PopUpCondition
extends Resource

@export var enabled := true
@export var script_condition: GDScript

func condition() -> bool:
	var instance = script_condition.new()
	return instance.condition()


