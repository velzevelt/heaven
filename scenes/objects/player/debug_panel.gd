extends VBoxContainer

func _ready():
	visible = DebugLayer.visible


func _process(_delta):
	if Input.is_action_just_pressed('show_debug'):
		visible = DebugLayer.visible
