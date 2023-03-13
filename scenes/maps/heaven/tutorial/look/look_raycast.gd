extends Node

signal target_captured(target)
signal target_losted(target)

@export var target_group = 'look_target'

@onready var raycast = get_parent() as RayCast3D
var target = null

func _physics_process(_delta):
	if raycast.is_colliding():
		if target == null:
			target = raycast.get_collider().owner
			target_captured.emit(target)
	else:
		if is_instance_valid(target):
			target_losted.emit(target)
			target = null

func _ready():
	target_captured.connect(_on_target_captured)
	target_losted.connect(_on_target_losted)
	

func _on_target_captured(target):
	if target.is_in_group(target_group):
		if target.has_method('on_focus'):
			target.on_focus()

func _on_target_losted(target):
	if target.is_in_group(target_group):
		if target.has_method('focus_losted'):
			target.focus_losted()
