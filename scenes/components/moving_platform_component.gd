class_name MovingPlatformComponent 
extends PlatformComponent
@tool

signal move_started
signal move_ended
signal _path_follow_changed

@export var autoplay := true
@export var loop := true
@export_range(1.0, 15.0, 1.0) var anim_duration := 3.0

@export_node_path(PathFollow3D) var path_follow:
	set(value):
		path_follow = value
		_path_follow_changed.emit()

var moving := false


func _ready():
	_path_follow_changed.connect(func(): update_configuration_warnings())
	super()


func _initialize():
	super()
	path_follow = get_node(path_follow)
	
	move_started.connect(func(): moving = true)
	move_ended.connect(func(): moving = false)
	
	if autoplay:
		move_platform()


func _get_configuration_warnings():
	var warnings = super()
	if not path_follow is NodePath:
		warnings.append('This node require PathFollow')
	
	return warnings


func _on_player_entered():
	if not moving:
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



