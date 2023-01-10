class_name CrosshairComponent extends Node
@tool

@export_node_path(RayCast3D) var player_raycast:
	set(value):
		player_raycast = value
		update_configuration_warnings()

@export_node_path(CanvasItem) var crosshair_sprite:
	set(value):
		crosshair_sprite = value
		update_configuration_warnings()

@export_range(0.08, 1.0, 0.01) var anim_duration = 1.0


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
			_animate(Color.WHITE, Vector2.ONE)
		else:
			_animate(Color(1, 1, 1, 0.5), Vector2(0.5, 0.5))

func _animate(new_modulate : Color, new_scale : Vector2):
	var tween = create_tween()
	tween.tween_property(crosshair_sprite, 'modulate', new_modulate, anim_duration)
	tween.parallel()
	tween.tween_property(crosshair_sprite, 'scale', new_scale, anim_duration)
