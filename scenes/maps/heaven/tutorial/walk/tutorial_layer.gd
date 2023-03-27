extends CanvasLayer

@export_range(0.1, 4.0, 0.1) var anim_duration := 1.5
@export_range(100, 5000, 50) var offset_value := 500

@export_range(0.1, 10.0, 0.1) var delay_to_hide := 1.5
@onready var init_offset = self.offset
var appeared = false

@export var highlight_style: StyleBoxFlat
var _labels: Array


@onready var _init_slyle = _labels[0].get_theme_stylebox('normal').duplicate()

func _ready():
	_labels[0] = $VBoxContainer/LabelS
	_labels[1] = $VBoxContainer/LabelW
	_labels[2] = $VBoxContainer/LabelD
	_labels[3] = $VBoxContainer/LabelA
	
	offset.x += offset_value
	await animate(init_offset).finished
	appeared = true


func animate(new_offset):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, 'offset', new_offset, anim_duration)
	return tween


func _input(_event):
	pass
#	if Input.is_action_just_pressed("jump"):
#		_label.add_theme_stylebox_override('normal', highlight_style)
#	if Input.is_action_just_released("jump"):
#		_label.add_theme_stylebox_override('normal', _init_slyle)
