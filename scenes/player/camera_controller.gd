extends Node3D

var captured = false
var mouse_sensitivity := 0.3

func _input(event):
	if event is InputEventMouseMotion:
		owner.rotate_y(  deg_to_rad(-event.relative.x * mouse_sensitivity) )
		self.rotate_x( deg_to_rad(-event.relative.y * mouse_sensitivity) )
		self.rotation.x = clamp( self.rotation.x, deg_to_rad(-90), deg_to_rad(90) )

func _process(delta):
	if Input.is_action_just_pressed("test"):
		captured = !captured
		if captured: Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE 
