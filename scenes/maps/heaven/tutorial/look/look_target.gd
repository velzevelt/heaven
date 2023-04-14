extends Node3D

signal activated(object)

@export var final_color: Color
@export var anim_duration := 0.5

@onready var mesh = $PlatformBody/MeshInstance3D
@onready var label = $Label3D as Label3D

var _init_color: Color
var _tween
var _activated := false

func _ready():
	if mesh != null:
		var init_material = mesh.get_active_material(0).duplicate()
		_init_color = init_material.albedo_color
		mesh.material_override = init_material

func on_focus():
	if not _activated:
		_tween = create_tween()
		_tween.set_parallel()
		_tween.tween_property(mesh.material_override, 'albedo_color', final_color, anim_duration)
#		_tween.tween_property(mesh, 'transparency', 1.0, anim_duration)
		_tween.tween_callback(func(): label.visible = false).set_delay(anim_duration)
		_activated = true
		activated.emit(self)

func focus_losted():
	pass
#	activated.emit(self)
