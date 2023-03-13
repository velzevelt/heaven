class_name Crosshair
extends Panel

@onready var crosshair_sprite = self
@export_range(0.08, 1.0, 0.01) var anim_duration = 1.0

@export var style: CrosshairStyle = preload("res://scenes/objects/player/default_crosshair_style.tres")

@onready var _init_style = style.duplicate()



func _ready():
	Events.player_target_spotted.connect(on_target_spotted)
	Events.player_target_losted.connect(on_target_losted)
	style = style.duplicate()
	
	crosshair_sprite.modulate = style.out_modulate
	crosshair_sprite.custom_minimum_size = style.out_size

func _animate(new_modulate: Color, new_size: Vector2):
	var tween = create_tween()
	tween.tween_property(crosshair_sprite, 'modulate', new_modulate, anim_duration)
	tween.parallel()
	tween.tween_property(crosshair_sprite, 'custom_minimum_size', new_size, anim_duration)

func animate_in():
	_animate(style.in_modulate, style.in_size)

func animate_out():
	_animate(style.out_modulate, style.out_size)

func on_target_spotted(override_crosshair):
	style = override_crosshair.style
	animate_in()

func on_target_losted(_crosshair):
	style = _init_style
	animate_out()
