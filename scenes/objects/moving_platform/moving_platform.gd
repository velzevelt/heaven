class_name MovingPlatform extends Platform

signal move_started
signal move_ended

@export var autoplay := true
@export var loop := true
@export var anim_duration := 3.0

@onready var path_follow : PathFollow3D = $Path3D/PathFollow3D

var tween
var init_progress := 0.0
var final_progress := 1.0


func _ready():
	super()
	
	tween = create_tween()
	tween.stop()
	tween.finished.connect(_on_tween_finished)
	
	if autoplay:
		move_platform()


func _on_player_entered():
	move_platform()


func move_platform():
	if !tween.is_running():
		var progress_ratio = final_progress if path_follow.progress_ratio == init_progress else init_progress
		Logger.debug_log(progress_ratio)
		tween = create_tween()
		tween.stop()
		tween.tween_property(path_follow, 'progress_ratio', progress_ratio, anim_duration)
		tween.play()
		move_started.emit()
	else:
		Logger.debug_log('121')

func _on_tween_finished():
	if loop:
		move_platform()
	else:
		move_ended.emit()
