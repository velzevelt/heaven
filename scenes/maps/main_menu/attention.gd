extends Panel

func _ready():
	visible = OS.get_name() == 'Web'


func _on_ok_button_pressed():
	visible = false
