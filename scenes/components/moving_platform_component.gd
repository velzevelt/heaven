@tool
class_name MovingPlatformComponent 
extends PlatformComponent

signal move_started
signal move_ended

@export var autoplay := true
@export var loop := true
@export_range(1.0, 15.0, 1.0) var anim_duration := 3.0

@export_node_path("PathFollow3D") var path_follow:
	set(value):
		path_follow = value
		update_configuration_warnings()


var _moving := false


func _initialize():
	super()
	path_follow = get_node(path_follow)
	
	move_started.connect(func(): _moving = true)
	move_ended.connect(func(): _moving = false)
	
	if autoplay:
		move_platform()


func _get_configuration_warnings():
	if not path_follow is NodePath:
		return ['Require PathFollow']
	
	return []


func _on_object_entered(_player):
	if not _moving:
		move_platform()


func move_platform():
	var tween = create_tween()
	tween.stop()
	tween.tween_property(path_follow, 'progress_ratio', 1.0, anim_duration)
	
	if not loop:
		tween.finished.connect(func(): move_ended.emit())
		tween.stop()
	else:
		tween.tween_property(path_follow, 'progress_ratio', 0.0, anim_duration)
		tween.set_loops()
	
	tween.play()
	move_started.emit()



