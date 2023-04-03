class_name VelzTime
extends Resource

@export var seconds := 0.0:
	get:
		if seconds > 59.9:
			seconds = 0.0
			self.minutes += 1
		return seconds
	set(value):
		seconds = value
		if seconds > 59.9:
			seconds = 0.0
			self.minutes += 1

@export var hours := 0

@export var minutes := 0:
	get:
		if minutes > 59:
			minutes = 0
			self.hours += 1
		return minutes
	set(value):
		minutes = value
		if minutes > 59:
			minutes = 0
			self.hours += 1


func _init(hours := 0, minutes := 0, seconds := 0.0):
	self.hours = hours
	self.minutes = minutes
	self.seconds = seconds


func get_vector():
	return Vector3(self.hours, self.minutes, self.seconds)

func get_formatted_str():
	return "%d:%d:%s" % [self.hours, self.minutes, snapped(self.seconds, 0.01)]
