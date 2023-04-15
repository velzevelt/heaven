extends "res://scenes/maps/heaven/tutorial/jump/jump_hook.gd"


func _ready():
	_init_slyle = $%LabelC.get_theme_stylebox('normal').duplicate()

func _input(_event):
	if Input.is_action_just_pressed('crouch'):
		var s = $%LabelC as Label
		s.add_theme_stylebox_override('normal', highlight_style)
	elif Input.is_action_just_released('crouch'):
		var s = $%LabelC as Label
		s.add_theme_stylebox_override('normal', _init_slyle)
