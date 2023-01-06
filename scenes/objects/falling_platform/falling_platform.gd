extends MovingPlatform

signal fell

@export var live_time := 10.0
@export var autofall := false
@onready var timer = $Timer as Timer


func _ready():
	if autofall:
		_on_player_entered()


func _on_player_entered():
	timer.start(live_time)


func _on_area_3d_body_entered(body):
	if body is Player:
		_on_player_entered()


func _on_timer_timeout():
	fell.emit()
	
	call_deferred('free')
