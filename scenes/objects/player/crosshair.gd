class_name CrosshairComponent extends Node
@tool

## Description
@export_node_path(RayCast3D) var player_raycast:
	set(value):
		player_raycast = value
		update_configuration_warnings()

@export_node_path(Node, Sprite3D) var crosshair_sprite:
	set(value):
		crosshair_sprite = value
		update_configuration_warnings()


func _ready():
	update_configuration_warnings()
	if not Engine.is_editor_hint():
		_initialize()


func _get_configuration_warnings():
	var warnings = []
	if not player_raycast is NodePath:
		warnings.append('Require RayCast3D')
	if not crosshair_sprite is NodePath:
		warnings.append('Require TextureRect')
	return warnings


func _initialize():
	player_raycast = get_node(player_raycast)
	crosshair_sprite = get_node(crosshair_sprite)


func _physics_process(_delta):
	if not Engine.is_editor_hint():
		if player_raycast.is_colliding():
			crosshair_sprite.visible = true
		else:
			crosshair_sprite.visible = false
