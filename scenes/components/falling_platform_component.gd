class_name FallingPlatformComponent 
extends PlatformComponent

signal fall_started(timer)
signal fell

@export var live_time := 10.0
@export var autofall := false
@onready var timer = Timer.new()


func _ready():
	super()
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	
	if autofall:
		player_entered.emit()



func _on_player_entered():
	super()
	
	timer.start(live_time)
	fall_started.emit(timer)


func _on_timer_timeout():
	fell.emit()
	Logger.debug_log('Platform has fallen')
	
	owner.call_deferred('free')
