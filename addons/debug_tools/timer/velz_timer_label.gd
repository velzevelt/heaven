class_name VelzTimerLabel
extends Label

@export var timer: VelzTimer

func _ready():
	timer.time_updated.connect(_on_time_updated)

func _on_time_updated(new_time):
	text = new_time.get_formatted_str()
