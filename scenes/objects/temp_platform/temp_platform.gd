extends Node3D

@export var live_time := 10.0
@export var autostart := false
@export var touch_respond := true
@onready var timer = $Timer as Timer


func _ready():
	if autostart:
		_on_player_entered()


func _on_player_entered():
	timer.start(live_time)


func _on_area_3d_body_entered(body):
	if body is Player and touch_respond:
		_on_player_entered()


func _on_timer_timeout():
	#
	call_deferred('free')
