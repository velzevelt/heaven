extends VBoxContainer

func _ready():
	visible = DebugLayer.visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('show_debug'):
		visible = DebugLayer.visible
