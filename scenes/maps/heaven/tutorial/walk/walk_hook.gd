extends CanvasLayer

@export_range(0.1, 4.0, 0.1) var anim_duration := 1.5
@export_range(100, 5000, 50) var offset_value := 500

@export_range(0.1, 10.0, 0.1) var delay_to_hide := 1.5
@onready var init_offset = self.offset
var appeared = false

@export var highlight_style: StyleBoxFlat

var _init_slyle

#@onready var _init_slyle = _labels[0].get_theme_stylebox('normal').duplicate()

func _ready():
	_init_slyle = $%LabelS.get_theme_stylebox('normal').duplicate()
	
	offset.x += offset_value
	await animate(init_offset).finished
	appeared = true


func animate(new_offset):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, 'offset', new_offset, anim_duration)
	return tween


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
