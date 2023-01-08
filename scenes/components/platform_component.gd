class_name PlatformComponent 
extends Node3D
@tool

signal player_entered
signal player_exited

signal _area_changed

@export_node_path(Area3D) var area:
	set(value):
		area = value
		_area_changed.emit()


func _ready():
	_area_changed.connect(func(): print(111))
	update_configuration_warnings()
	
	if not Engine.is_editor_hint():
		_initialize()


func _initialize():
	area = get_node(area)
	area.body_entered.connect(_on_area_3d_body_entered)
	area.body_exited.connect(_on_area_3d_body_exited)
	
	player_entered.connect(_on_player_entered)
	player_exited.connect(_on_player_exited)


func _get_configuration_warnings():
	if is_instance_valid(area):
		return []
	
	return ['This node require Area3D']


func _on_area_3d_body_entered(body):
	if body is Player:
		player_entered.emit()


func _on_area_3d_body_exited(body):
	if body is Player:
		player_exited.emit()


func _on_player_entered():
	pass

func _on_player_exited():
	pass

