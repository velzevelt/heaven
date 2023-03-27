class_name VelzTimer
extends Node

signal time_updated(new_time)

@onready var time: VelzTime = VelzTime.new()

@export var enabled := true:
	get:
		return enabled
	set(value):
		enabled = value


func _ready():
	if enabled:
		start_timer()


func _physics_process(delta):
	if enabled:
		time.seconds += delta
		time_updated.emit(time)


func start_timer():
	pass


func stop_timer():
	pass

func reset_time():
	time = VelzTime.new()


class VelzTime:
	var seconds := 0.0:
		get:
			if seconds > 60.0:
				seconds = 0.0
				self.minutes += 1
			return seconds
		set(value):
			seconds = value
	
	var hours := 0
	
	var minutes := 0:
		get:
			if minutes > 60:
				minutes = 0
				self.hours += 1
			return minutes
		set(value):
			minutes = value
	
	
	func _init(hours := 0, minutes := 0, seconds := 0.0):
		self.hours = hours
		self.minutes = minutes
		self.seconds = seconds
