extends Window


func _on_close_requested():
	self.visible = false


func _on_debug_layer_visibility_changed():
	self.visible = owner.visible
	print(self.visible)


func _on_focus_entered():
	get_tree().paused = true


func _on_focus_exited():
	get_tree().paused = false
