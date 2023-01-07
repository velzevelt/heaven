class_name MovingPlatform extends Platform

signal move_started
signal move_ended

@export var autoplay := true
@export var loop := true
@export var anim_duration := 3.0

@onready var path_follow : PathFollow3D = $Path3D/PathFollow3D


func _ready():
	super()
	
	if autoplay:
		move_platform()


func _on_player_entered():
	move_platform()


func move_platform():
	var tween = create_tween()
	tween.stop()
	tween.tween_property(path_follow, 'progress_ratio', 1.0, anim_duration)
	
	if not loop:
		tween.finished.connect(func(): move_ended.emit())
	else:
		tween.tween_property(path_follow, 'progress_ratio', 0.0, anim_duration)
		tween.set_loops()
	
	tween.play()
	move_started.emit()



