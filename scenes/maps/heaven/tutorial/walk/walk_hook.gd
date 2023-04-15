class_name WalkHook
extends Control

@export var highlight_style: StyleBoxFlat
var _init_slyle

func _ready():
	_init_slyle = $%LabelW.get_theme_stylebox('normal').duplicate()

func _input(_event):
	if Input.is_action_just_pressed('forward'):
		var w = $%LabelW as Label
		w.add_theme_stylebox_override('normal', highlight_style)
	if Input.is_action_just_released("forward"):
		var w = $%LabelW as Label
		w.add_theme_stylebox_override('normal', _init_slyle)
	
	if Input.is_action_just_pressed('backward'):
		var w = $%LabelS as Label
		w.add_theme_stylebox_override('normal', highlight_style)
	if Input.is_action_just_released("backward"):
		var w = $%LabelS as Label
		w.add_theme_stylebox_override('normal', _init_slyle)
	
	if Input.is_action_just_pressed('right'):
		var w = $%LabelD as Label
		w.add_theme_stylebox_override('normal', highlight_style)
	if Input.is_action_just_released('right'):
		var w = $%LabelD as Label
		w.add_theme_stylebox_override('normal', _init_slyle)
	
	if Input.is_action_just_pressed('left'):
		var w = $%LabelA as Label
		w.add_theme_stylebox_override('normal', highlight_style)
	if Input.is_action_just_released('left'):
		var w = $%LabelA as Label
		w.add_theme_stylebox_override('normal', _init_slyle)
