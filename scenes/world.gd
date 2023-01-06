extends Node3D


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()





func _on_moving_platform_visibility_changed():
	pass # Replace with function body.
