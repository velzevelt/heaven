extends MovingPlatform

signal fall_started(timer)
signal fell

@export var live_time := 10.0
@export var autofall := false
@onready var timer = $Timer as Timer


func _ready():
	super()
	
	if autofall:
		player_entered.emit()



func _on_player_entered():
	super()
	
	timer.start(live_time)
	fall_started.emit(timer)


func _on_timer_timeout():
	fell.emit()
	Logger.debug_log('Platform has fallen')
	
	call_deferred('free')
