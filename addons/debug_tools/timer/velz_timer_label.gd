class_name VelzTimerLabel
extends Label

@export var timer: VelzTimer

func _ready():
	timer.time_updated.connect(_on_time_updated)

func _on_time_updated(new_time):
	text = "%d : %d : %s" % [new_time.hours, new_time.minutes, snapped(new_time.seconds, 0.01)]
