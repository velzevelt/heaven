extends Label



func _on_h_slider_value_changed(value):
	text = str(value * 100.0)
