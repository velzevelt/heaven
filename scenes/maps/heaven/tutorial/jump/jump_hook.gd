extends WalkHook


func _ready():
	_init_slyle = $%LabelSpace.get_theme_stylebox('normal').duplicate()


func _input(_event):
	if Input.is_action_just_pressed('jump'):
		var s = $%LabelSpace as Label
		s.add_theme_stylebox_override('normal', highlight_style)
	elif Input.is_action_just_released('jump'):
		var s = $%LabelSpace as Label
		s.add_theme_stylebox_override('normal', _init_slyle)
