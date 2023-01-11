class_name CrosshairComponent extends Node
@tool

@export_node_path(CanvasItem) var crosshair_sprite:
	set(value):
		crosshair_sprite = value
		update_configuration_warnings()

@export_range(0.08, 1.0, 0.01) var anim_duration = 1.0

@export var out_modulate: Color = Color.GRAY
@export var out_scale: Vector2 = Vector2(0.5, 0.5)
@export var in_modulate: Color = Color.WHITE
@export var in_scale: Vector2 = Vector2(0.6, 0.6)

func _ready():
	update_configuration_warnings()
	if not Engine.is_editor_hint():
		_initialize()
		crosshair_sprite.modulate = out_modulate
		crosshair_sprite.scale = out_scale


func _get_configuration_warnings():
	var warnings = []
	if not crosshair_sprite is NodePath:
		warnings.append('Require TextureRect')
	return warnings


func _initialize():
	crosshair_sprite = get_node(crosshair_sprite)


func _animate(new_modulate: Color, new_scale: Vector2):
	var tween = create_tween()
	tween.tween_property(crosshair_sprite, 'modulate', new_modulate, anim_duration)
	tween.parallel()
	tween.tween_property(crosshair_sprite, 'scale', new_scale, anim_duration)

func animate_in():
	_animate(in_modulate, in_scale)

func animate_out():
	_animate(out_modulate, out_scale)

func on_target_spotted():
	animate_in()

func on_target_losted():
	animate_out()
