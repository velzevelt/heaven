### UNUSABLE NOW ###
extends Window


func _ready():
	visible = false


func _process(_delta):
	if Input.is_action_just_pressed('show_console'):
		visible = !visible


func _on_close_requested():
	visible = false


func _on_focus_entered():
	get_tree().paused = true


func _on_focus_exited():
	get_tree().paused = false
