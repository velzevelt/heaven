extends Control

@export var arrow_up: TextureRect
@export var arrow_left: TextureRect
@export var arrow_right: TextureRect
@export var arrow_down: TextureRect

@export var highlight_modulate: Color
@onready var _init_modulate = arrow_up.modulate

var relative: Vector2 = Vector2()
var relative_flag := true

func _input(event):
	if event is InputEventMouseMotion:
		relative = event.relative

func _process(_delta):
	if relative.x > 0:
		arrow_right.modulate = highlight_modulate
		arrow_left.modulate = _init_modulate
#		print("RIGHT")
	elif relative.x < 0:
		arrow_left.modulate = highlight_modulate
		arrow_right.modulate = _init_modulate
#		print("LEFT")
	elif relative.x == 0:
		arrow_right.modulate = _init_modulate
		arrow_left.modulate = _init_modulate
	
	if relative.y > 0:
		arrow_down.modulate = highlight_modulate
		arrow_up.modulate = _init_modulate
#		print("DOWN")
	elif relative.y < 0:
		arrow_up.modulate = highlight_modulate
		arrow_down.modulate = _init_modulate
#		print("UP")
	elif relative.y == 0:
		arrow_up.modulate = _init_modulate
		arrow_down.modulate = _init_modulate
	
	_reset_relative()

func _reset_relative():
	if relative_flag:
		relative_flag = false
		await get_tree().create_timer(0.4).timeout
		relative = Vector2()
		relative_flag = true
