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

